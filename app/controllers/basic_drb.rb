#!/usr/bin/env ruby

##
# Enhanced XMPP sample using a DRb server listener.
#
# Author: Geoffrey Grosenbach http://peepcode.com



require 'drb'

require 'yaml'

require 'xmpp4r/pubsub/iq/pubsub'
require 'xmpp4r/pubsub/children/event'
require 'xmpp4r/pubsub/children/item'
require 'xmpp4r/pubsub/children/items'
require 'xmpp4r/pubsub/children/subscription'
require 'xmpp4r/pubsub/children/unsubscribe'
require 'xmpp4r/pubsub/children/node_config'
require 'xmpp4r/pubsub/children/subscription_config'
require 'xmpp4r/pubsub/children/retract'
require 'xmpp4r/dataforms'

module Jabber
  module PubSub
    ##
    # A Helper representing a PubSub Service
    class ServiceHelper

      ##
      # Creates a new representation of a pubsub service
      # stream:: [Jabber::Stream]
      # pubsubjid:: [String] or [Jabber::JID]
      def initialize(stream, pubsubjid)
        @stream = stream
        @pubsubjid = pubsubjid
        @event_cbs = CallbackList.new
        @stream.add_message_callback(200,self) { |message|
          handle_message(message)
        }
      end

      ##
      # get all subscriptions on a pubsub component
      # return:: [Hash] of [PubSub::Subscription]
      def get_subscriptions_from_all_nodes
        iq = basic_pubsub_query(:get)
        entities = iq.pubsub.add(REXML::Element.new('subscriptions'))
        res = nil
        @stream.send_with_id(iq) { |reply|
          if reply.pubsub.first_element('subscriptions')
            res = []
            reply.pubsub.first_element('subscriptions').each_element('subscription') { |subscription|
              res << Jabber::PubSub::Subscription.import(subscription)
            }
          end
        }

        res
      end

      ##
      # get subids for a passed node
      # return:: [Array] of subids
      def get_subids_for(node)
        ret = []
        get_subscriptions_from_all_nodes.each do |subscription|
          if subscription.node == node
            ret << subscription.subid
          end
        end
        return ret
      end

      ##
      # subscribe to a node
      # node:: [String]
      # return:: [Hash] of { attributename => value }
      def subscribe_to(node)
        iq = basic_pubsub_query(:set)
        sub = REXML::Element.new('subscribe')
        sub.attributes['node'] = node
        sub.attributes['jid'] = @stream.jid.strip.to_s
        iq.pubsub.add(sub)
        res = nil
        @stream.send_with_id(iq) do |reply|
          pubsubanswer = reply.pubsub
          if pubsubanswer.first_element('subscription')
            res = PubSub::Subscription.import(pubsubanswer.first_element('subscription'))
          end
        end # @stream.send_with_id(iq)
        res
      end

      ##
      # Unsubscribe from a node with an optional subscription id
      #
      # May raise ServerError
      # node:: [String]
      # subid:: [String] or nil (not supported)
      # return:: true
      def unsubscribe_from(node, subid=nil)
        ret = []
        if subid.nil?
          subids = get_subids_for(node)
        else
          subids = [ subid ]
        end
        subids << nil if subids.empty?
        subids.each do |sid|
          iq = basic_pubsub_query(:set)
          unsub = PubSub::Unsubscribe.new
          unsub.node = node
          unsub.jid = @stream.jid.strip
          unsub.subid = sid
          iq.pubsub.add(unsub)
          res = false
          @stream.send_with_id(iq) { |reply|
            res = reply.kind_of?(Jabber::Iq) and reply.type == :result
          } # @stream.send_with_id(iq)
          ret << res
        end
        ret
      end

      ##
      # gets all items from a pubsub node
      # node:: [String]
      # count:: [Fixnum]
      # subid:: [String]
      # return:: [Hash] { id => [Jabber::PubSub::Item] }
      def get_items_from(node, count=nil, subid=nil)
        if subid.nil?
          # Hm... no subid passed. Let's see if we can provide one.
          subids = get_subids_for(node)
          if ! subids.empty?
            # If more than one, sorry. We'll just respect the first.
            subid = subids[0]
          end
        end
        iq = basic_pubsub_query(:get)
        items = Jabber::PubSub::Items.new
        items.max_items = count
        items.subid = subid unless subid.nil?  # if subid is still nil, we haven't any... why bother?
        items.node = node
        iq.pubsub.add(items)
        res = nil
        @stream.send_with_id(iq) { |reply|
          if reply.kind_of?(Iq) and reply.pubsub and reply.pubsub.first_element('items')
            res = {}
            reply.pubsub.first_element('items').each_element('item') do |item|
              res[item.attributes['id']] = item.children.first if item.children.first
            end
          end
          true
        }
        res
      end

      ##
      # NOTE: this method sends only one item per publish request because some services
      # may not allow batch processing.  Maybe this will changed in the future?
      # node:: [String]
      # item:: [Jabber::PubSub::Item]
      # return:: true
      def publish_item_to(node,item)
        iq = basic_pubsub_query(:set)
        publish = iq.pubsub.add(REXML::Element.new('publish'))
        publish.attributes['node'] = node

        if item.kind_of?(Jabber::PubSub::Item)
          publish.add(item)
          @stream.send_with_id(iq)
        end
      end

      ##
      # node:: [String]
      # item:: [REXML::Element]
      # id:: [String]
      # return:: true
      def publish_item_with_id_to(node,item,id)
        iq = basic_pubsub_query(:set)
        publish = iq.pubsub.add(REXML::Element.new('publish'))
        publish.attributes['node'] = node

        if item.kind_of?(REXML::Element)
          xmlitem = Jabber::PubSub::Item.new
          xmlitem.id = id
          xmlitem.import(item)
          publish.add(xmlitem)
        else
          raise "given item is not a proper xml document or Jabber::PubSub::Item"
        end
        @stream.send_with_id(iq)
      end

      ##
      # deletes an item from a persistent node
      # node:: [String]
      # item_id:: [String] or [Array] of [String]
      # return:: true
      def delete_item_from(node, item_id)
        iq = basic_pubsub_query(:set)
        retract = iq.pubsub.add(Jabber::PubSub::Retract.new)
        retract.node = node

        if item_id.kind_of? Array
          item_id.each { |id|
            xmlitem = Jabber::PubSub::Item.new
            xmlitem.id = id
            retract.add(xmlitem)
          }
        else
          xmlitem = Jabber::PubSub::Item.new
          xmlitem.id = item_id
          retract.add(xmlitem)
        end

        @stream.send_with_id(iq)
      end

      ##
      # purges all items on a persistent node
      # node:: [String]
      # return:: true
      def purge_items_from(node)
        iq = basic_pubsub_query(:set, true)
        purge = REXML::Element.new('purge')
        purge.attributes['node'] = node
        iq.pubsub.add(purge)
        @stream.send_with_id(iq)
      end

      ##
      # Create a new node on the pubsub service
      # node:: [String] the node name - otherwise you get a automatically generated one (in most cases)
      # configure:: [Jabber::PubSub::NodeConfig] if you want to configure your node (default nil)
      # return:: [String]
      def create_node(node = nil, configure = Jabber::PubSub::NodeConfig.new)
        rnode = nil
        iq = basic_pubsub_query(:set)
        iq.pubsub.add(REXML::Element.new('create')).attributes['node'] = node
        if configure
          if configure.kind_of?(Jabber::PubSub::NodeConfig)
            iq.pubsub.add(configure)
          end
        end

        @stream.send_with_id(iq) do |reply|
          if reply.kind_of?(Jabber::Iq) and reply.type == :result
            rnode = node
          end
        end

        rnode
      end

      ##
      # Create a new collection node on the pubsub service
      # node:: [String] the node name - otherwise you get an automatically generated one (in most cases)
      # configure:: [Jabber::PubSub::NodeConfig] if you want to configure your node (default nil)
      # return:: [String]
      def create_collection_node(node = nil, configure = Jabber::PubSub::NodeConfig.new)
        if configure.options['pubsub#node_type'] && configure.options['pubsub#node_type'] != 'collection'
          raise Jabber::ArgumentError, "Invalid node_type specified in node configuration. Either do not specify one, or use 'collection'"
        end
        configure.options = configure.options.merge({'pubsub#node_type' => 'collection'})
        create_node(node, configure)
      end

      ##
      # get configuration from a node
      # node:: [String]
      # return:: [Jabber::PubSub::Configure]
      def get_config_from(node)
        iq = basic_pubsub_query(:get, true)
        iq.pubsub.add(Jabber::PubSub::OwnerNodeConfig.new(node))
        ret = nil
        @stream.send_with_id(iq) do |reply|
          ret = reply.pubsub.first_element('configure')
        end
        ret
      end

      ##
      # set configuration for a node
      # node:: [String]
      # options:: [Jabber::PubSub::NodeConfig]
      # return:: true on success
      def set_config_for(node, config)
        iq = basic_pubsub_query(:set, true)
        iq.pubsub.add(config)
        @stream.send_with_id(iq)
      end

      ##
      # Delete a pubsub node
      # node:: [String]
      # return:: true
      def delete_node(node)
        iq = basic_pubsub_query(:set,true)
        iq.pubsub.add(REXML::Element.new('delete')).attributes['node'] = node
        @stream.send_with_id(iq)
      end

      def set_affiliations(node, jid, role = 'publisher')
        iq = basic_pubsub_query(:set, true)
        affiliations = iq.pubsub.add(REXML::Element.new('affiliations'))
        affiliations.attributes['node'] = node
        affiliation = affiliations.add(REXML::Element.new('affiliation'))
        affiliation.attributes['jid'] = jid.to_s
        affiliation.attributes['affiliation'] = role.to_s
        res = nil
        @stream.send_with_id(iq) { |reply|
          true
        }
        res
      end

      ##
      # shows the affiliations on a pubsub service
      # node:: [String]
      # return:: [Hash] of { node => symbol }
      def get_affiliations(node = nil)
        iq = basic_pubsub_query(:get)
        affiliations = iq.pubsub.add(REXML::Element.new('affiliations'))
        affiliations.attributes['node'] = node
        res = nil
        @stream.send_with_id(iq) { |reply|
          if reply.pubsub.first_element('affiliations')
            res = {}
            reply.pubsub.first_element('affiliations').each_element('affiliation') do |affiliation|
              # TODO: This should be handled by an affiliation element class
              aff = case affiliation.attributes['affiliation']
                      when 'owner' then :owner
                      when 'publisher' then :publisher
                      when 'none' then :none
                      when 'outcast' then :outcast
                      else nil
                    end
              res[affiliation.attributes['node']] = aff
            end
          end
          true
        }
        res
      end

      ##
      # shows all subscriptions on the given node
      # node:: [String]
      # return:: [Array] of [Jabber::Pubsub::Subscription]
      def get_subscriptions_from(node)
        iq = basic_pubsub_query(:get)
        entities = iq.pubsub.add(REXML::Element.new('subscriptions'))
        entities.attributes['node'] = node
        res = nil
        @stream.send_with_id(iq) { |reply|
          if reply.pubsub.first_element('subscriptions')
            res = []
            if reply.pubsub.first_element('subscriptions').attributes['node'] == node
              reply.pubsub.first_element('subscriptions').each_element('subscription') { |subscription|
              res << PubSub::Subscription.import(subscription)
              }
            end
          end
          true
        }
        res
      end

      ##
      # shows all jids of subscribers of a node
      # node:: [String]
      # return:: [Array] of [String]
      def get_subscribers_from(node)
        res = []
        get_subscriptions_from(node).each { |sub|
          res << sub.jid
        }
        res
      end


      ##
      # get options from a subscription
      # node:: [String]
      # jid:: [Jabber::JID] or [String]
      # subid:: [String] or nil
      # return:: [Jabber::PubSub::OwnerConfigure]
      def get_options_from(node, jid, subid = nil)
        iq = basic_pubsub_query(:get)
        iq.pubsub.add(Jabber::PubSub::SubscriptionConfig.new(node, jid.kind_of?(String) ? Jabber::JID.new(jid).strip: jid.strip, subid))
        ret = nil
        @stream.send_with_id(iq) do |reply|
          ret = reply.pubsub.first_element('options')
        end
        ret
      end

      ##
      # set options for a subscription
      # node:: [String]
      # jid:: [Jabber::JID] or [String]
      # options:: [Jabber::PubSub::SubscriptionConfig} specifying configuration options
      # subid:: [String] or nil
      # return:: true
      def set_options_for(node, jid, options, subid = nil)
        iq = basic_pubsub_query(:set)
        iq.pubsub.add(Jabber::PubSub::SubscriptionConfig.new(node, jid.kind_of?(String) ? Jabber::JID.new(jid).strip: jid.strip, options, subid))
        ret = false
        @stream.send_with_id(iq) do  |reply|
          ret = ( reply.type == :result )
        end

        ret
      end

      ##
      # String representation
      # result:: [String] The PubSub service's JID
      def to_s
        @pubsubjid.to_s
      end

      ##
      # Register callbacks for incoming events
      # (i.e. Message stanzas containing) PubSub notifications
      def add_event_callback(prio = 200, ref = nil, &block)
        @event_cbs.add(prio, ref, block)
      end

      private

      ##
      # creates a basic pubsub iq
      # basic_pubsub_query(type)
      # type:: [Symbol]
      def basic_pubsub_query(type,ownerusecase = false)
        iq = Jabber::Iq.new(type,@pubsubjid)
        if ownerusecase
          iq.add(IqPubSubOwner.new)
        else
          iq.add(IqPubSub.new)
        end
        iq.from = @stream.jid #.strip
        iq
      end

      ##
      # handling incoming events
      # handle_message(message)
      # message:: [Jabber::Message]
      def handle_message(message)
        if message.from == @pubsubjid and message.first_element('event').kind_of?(Jabber::PubSub::Event)
          event = message.first_element('event')
          @event_cbs.process(event)
        end
      end
    end
  end
end

module Jabber
  module PubSub
    ##
    # A Helper representing a PubSub Service
    class ServiceHelper
      def get_subscriptions_from_new(node)
        puts "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA"
             iq = basic_pubsub_query(:get,true)
             entities = iq.pubsub.add(REXML::Element.new('subscriptions'))
             entities.attributes['node'] = node
             res = nil
             @stream.send_with_id(iq) { |reply|
               if reply.pubsub.first_element('subscriptions')
                 res = []
                 if reply.pubsub.first_element('subscriptions').attributes['node'] == node
                   reply.pubsub.first_element('subscriptions').each_element('subscription') { |subscription|
                   res << PubSub::Subscription.import(subscription)
                   }
                 end
               end
               true
             }
             res
           end
    end
  end
end
class Jabber::JID

  ##
  # Convenience method to generate node@domain

  def to_short_s
    s = []
    s << "#@node@" if @node
    s << @domain
    return s.to_s
  end

end

class TopfunkyIM
  
 

  def initialize(username, password, config={}, stop_thread=true)
    @config          = config
    @friends_sent_to = []
    @friends_online  = {}
    @mainthread      = Thread.current

    login(username, password)

   
   
    send_initial_presence

    Thread.stop if stop_thread
  end
  
  def self.register(username,password)
     jid    = Jabber::JID.new("#{username}@idlecampus.com")
     client = Jabber::Client.new(jid)
     Jabber::debug = true if Rails.env.development?
     client.connect
     fields = {}
    
     client.register(password, fields)
  end

  def login(username, password)
    @jid    = Jabber::JID.new(username)
    @client = Jabber::Client.new(@jid)
    @client.connect
    @client.auth(password)
   
    
   
    
  end

  def logout
    # @mainthread.wakeup
    @client.close
    
  end
  
  def create_group(group)
   
    
    service = 'pubsub.idlecampus.com'
   
    options = {'pubsub#access_model'=>'open'}
    
    @pubsub = Jabber::PubSub::ServiceHelper.new(@client, service)

    @pubsub.create_node(group, Jabber::PubSub::NodeConfig.new(group, {'pubsub#access_model'=>'open','pubsub#notification_type' => 'normal'}))

     
      
  end
  
  def publish(message,group)
     item = Jabber::PubSub::Item.new
     xml = REXML::Element.new("value")
     xml.text = message

     item.add(xml);
     service = 'pubsub.idlecampus.com'
   
     options = {'pubsub#access_model'=>'open'}
    
     @pubsub = Jabber::PubSub::ServiceHelper.new(@client, service)
     @pubsub.publish_item_to(group, item)
  end
  
  def get_subscriptions_from_all_nodes
    service = 'pubsub.idlecampus.com'
   
    
    pubsub = Jabber::PubSub::ServiceHelper.new(@client, service)
    
    return pubsub.get_subscriptions_from_all_nodes
  end
  
  def get_subscriptions_from(group)
    
    service = 'pubsub.idlecampus.com'
   
    
    pubsub = Jabber::PubSub::ServiceHelper.new(@client, service)
    
  
    
    subscriptions =  pubsub.get_subscriptions_from_new(group)
    
    return subscriptions
    
    
  end


  def setup_avatar
    if vcard_config = @config['vcard']
      photo = IO::readlines(vcard_config['photo_path']).to_s
      @avatar_hash = Digest::SHA1.hexdigest(photo)
      vcard = Jabber::Vcard::IqVcard.new({
        'NICKNAME' => vcard_config['nickname'],
        'FN' => vcard_config['fn'],
        'URL' => vcard_config['url'],
        'PHOTO/TYPE' => 'image/png',
        'PHOTO/BINVAL' => Base64::encode64(photo)
      })
      Jabber::Vcard::Helper::set(@client, vcard)
    end
  end

  def send_initial_presence
    @client.send(Jabber::Presence.new.set_status("XMPP4R at #{Time.now.utc}"))
  end

  def listen_for_subscription_requests
    @roster   = Jabber::Roster::Helper.new(@client)

    @roster.add_subscription_request_callback do |item, pres|
      if pres.from.domain == @jid.domain
        log "ACCEPTING AUTHORIZATION REQUEST FROM: " + pres.from.to_s
        @roster.accept_subscription(pres.from)
      end
    end
  end

  def listen_for_messages
    @client.add_message_callback do |m|
      if m.type != :error
        if !@friends_sent_to.include?(m.from)
          msg = Jabber::Message.new(m.from, "I am a robot. You are connecting for the first time.")
          msg.type = :chat
          @client.send(msg)
          @friends_sent_to << m.from
        end

        case m.body.to_s
        when 'exit'
          msg      = Jabber::Message.new(m.from, "Exiting ...")
          msg.type = :chat
          @client.send(msg)

          logout

        when /\.png/

          puts "Changing to #{m.body}"
          if vcard_config = @config['vcard']
            photo = IO::readlines(m.body.to_s).to_s
            @avatar_hash = Digest::SHA1.hexdigest(photo)

            Thread.new do
              vcard = Jabber::Vcard::IqVcard.new({
                'NICKNAME' => vcard_config['nickname'],
                'FN' => vcard_config['fn'],
                'URL' => vcard_config['url'],
                'PHOTO/TYPE' => 'image/png',
                'PHOTO/BINVAL' => Base64::encode64(photo)
              })
              Jabber::Vcard::Helper::set(@client, vcard)
            end
            
            presence = Jabber::Presence.new(:chat, "Present with new avatar")
            x = presence.add(REXML::Element.new('x'))
            x.add_namespace 'vcard-temp:x:update'
            x.add(REXML::Element.new('photo')).text = @avatar_hash
            @client.send presence
            
          end

        else
          msg      = Jabber::Message.new(m.from, "You said #{m.body} at #{Time.now.utc}")
          msg.type = :chat
          @client.send(msg)
          puts "RECEIVED: " + m.body.to_s

        end
      else
        log [m.type.to_s, m.body].join(": ")
      end
    end
  end

  ##
  # TODO Do something with the Hash of online friends.

  def listen_for_presence_notifications
    @client.add_presence_callback do |m|
      case m.type
      when nil # status: available
        log "PRESENCE: #{m.from.to_short_s} is online"
        @friends_online[m.from.to_short_s] = true
      when :unavailable
        log "PRESENCE: #{m.from.to_short_s} is offline"
        @friends_online[m.from.to_short_s] = false
      end
    end
  end

  def send_message(to, message)
    log("Sending message to #{to}")
    msg      = Jabber::Message.new(to, message)
    msg.type = :chat
    @client.send(msg)    
  end

  def change_color(color_name=:blue)
    if vcard_config = @config['vcard']
      filename = case color_name
      when :blue
        'avatar-blue.png'
      when :red
        'avatar-red.png'
      end
      photo = IO::readlines(filename).to_s
      @avatar_hash = Digest::SHA1.hexdigest(photo)

      Thread.new do
        vcard = Jabber::Vcard::IqVcard.new({
          'NICKNAME' => vcard_config['nickname'],
          'FN' => vcard_config['fn'],
          'URL' => vcard_config['url'],
          'PHOTO/TYPE' => 'image/png',
          'PHOTO/BINVAL' => Base64::encode64(photo)
        })
        Jabber::Vcard::Helper::set(@client, vcard)
      end
      
      presence = Jabber::Presence.new(:chat, "Present with new avatar")
      x = presence.add(REXML::Element.new('x'))
      x.add_namespace 'vcard-temp:x:update'
      x.add(REXML::Element.new('photo')).text = @avatar_hash
      @client.send presence
    end    
  end

  def log(message)
    puts(message) if Jabber::debug
  end
  
  def subscribe(group)
    service = 'pubsub.idlecampus.com'
   
    options = {'pubsub#access_model'=>'open'}
    
    @pubsub = Jabber::PubSub::ServiceHelper.new(@client, service)
    
    @pubsub.subscribe_to(group)
  end

end



