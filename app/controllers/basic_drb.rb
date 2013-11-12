#!/usr/bin/env ruby

##
# Enhanced XMPP sample using a DRb server listener.
#
# Author: Geoffrey Grosenbach http://peepcode.com



require 'drb'

require 'yaml'

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

   
    # 
    # listen_for_subscription_requests
    # listen_for_presence_notifications
    # listen_for_messages

    send_initial_presence

    Thread.stop if stop_thread
  end
  
  def self.register(username,password)
     jid    = Jabber::JID.new("#{username}@idlecampus.com")
     client = Jabber::Client.new(jid)
     Jabber::debug = true
     client.connect
     fields = {}
    
     client.register(password, fields)
  end

  def login(username, password)
    @jid    = Jabber::JID.new(username)
    @client = Jabber::Client.new(@jid)
    @client.connect
    @client.auth(password)
    
    # service = 'pubsub.idlecampus.com'
   
    
    # pubsub = Jabber::PubSub::ServiceHelper.new(@client, service)
  #   
  #   pubsub.create_node("#{@jid}/groups", Jabber::PubSub::NodeConfig.new("#{@jid}/groups", {'pubsub#access_model'=>'open'}))
  #   
    
  end

  def logout
    # @mainthread.wakeup
    @client.close
    
  end
  
  def create_group(group)
    service = 'pubsub.idlecampus.com'
   
    options = {'pubsub#access_model'=>'open'}
    
    @pubsub = Jabber::PubSub::ServiceHelper.new(@client, service)
    
    
    # item1 = Jabber::PubSub::Item.new
       # item1.text = group
       
       @pubsub.create_node(group, Jabber::PubSub::NodeConfig.new(group, {'pubsub#access_model'=>'open'}))
       
       # item = Jabber::PubSub::Item.new
  #      xml = REXML::Element.new("value")
  #      xml.text = group
  # 
  #      item.add(xml);
       # publish item
       # pubsub.publish_item_to(node, item)
       
       
       
       # pubsub.publish_item_with_id_to("#{@jid}/groups", item, "blubb")
     
      
  end
  
  def publish(message,group)
     item = Jabber::PubSub::Item.new
     xml = REXML::Element.new("value")
     xml.text = message

     item.add(xml);
    
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

end



