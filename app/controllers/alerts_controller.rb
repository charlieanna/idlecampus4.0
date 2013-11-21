require 'drb'
require 'basic_drb'

class AlertsController < ApplicationController
  def new
    @alert = Alert.new
  end

  def create
    xmpp = DRbObject.new_with_uri 'druby://localhost:7777'
    xmpp.publish(params[:alert][:message], params[:alert][:group])
    render nothing: true
  end
end
