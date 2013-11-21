require 'drb'
require 'yaml'
module Jabber
  module PubSub
    #
    class ServiceHelper
      def get_subscriptions_from_new(node)
        iq = basic_pubsub_query(:get, true)
        entities = iq.pubsub.add(REXML::Element.new('subscriptions'))
        entities.attributes['node'] = node
        res = nil
        @stream.send_with_id(iq) do |reply|
          if reply.pubsub.first_element('subscriptions')
            res = []
            if reply.pubsub.first_element('subscriptions').attributes['node'] == node
              reply.pubsub.first_element('subscriptions').each_element('subscription') do |subscription|
                res << PubSub::Subscription.import(subscription)
              end
            end
          end
        true
        end
        res
      end
    end
  end
end
#
class Jabber::JID
  def to_short_s
    s = []
    s << '#@node@' if @node
    s << @domain
    s.to_s
  end
end
#
class TopfunkyIM
  def initialize(username, password, config = {}, stop_thread = true)
    @config          = config
    @friends_sent_to = []
    @friends_online  = {}
    @mainthread      = Thread.current
    login(username, password)
    send_initial_presence
    Thread.stop if stop_thread
  end

  def self.register(username, password)
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
    # options = { 'pubsub#access_model '=> 'open' }
    @pubsub = Jabber::PubSub::ServiceHelper.new(@client, service)
    @pubsub.create_node(group, Jabber::PubSub::NodeConfig.new(group,  'pubsub#access_model' => 'open' , 'pubsub#notification_type' => 'normal' ))
  end

  def publish(message, group)
    item = Jabber::PubSub::Item.new
    xml = REXML::Element.new('value')
    xml.text = message
    item.add(xml)
    service = 'pubsub.idlecampus.com'
    # options = { 'pubsub#access_model' => 'open' }
    @pubsub = Jabber::PubSub::ServiceHelper.new(@client, service)
    @pubsub.publish_item_to(group, item)
  end

  def get_subscriptions_from_all_nodes
    service = 'pubsub.idlecampus.com'
    pubsub = Jabber::PubSub::ServiceHelper.new(@client, service)
    pubsub.get_subscriptions_from_all_nodes
  end

  def get_subscriptions_from(group)
    service = 'pubsub.idlecampus.com'
    pubsub = Jabber::PubSub::ServiceHelper.new(@client, service)
    pubsub.get_subscriptions_from_new(group)
  end

  def send_initial_presence
    @client.send(Jabber::Presence.new.set_status("XMPP4R at #{Time.now.utc}"))
  end

  def log(message)
    puts(message) if Jabber::debug
  end

  def subscribe(group)
    service = 'pubsub.idlecampus.com'
    # options = { 'pubsub#access_model' => 'open' }
    @pubsub = Jabber::PubSub::ServiceHelper.new(@client, service)
    @pubsub.subscribe_to(group)
  end
end
