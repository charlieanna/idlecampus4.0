class AlertsController < ApplicationController
  def new
    @alert = Alert.new
  end

  def create
    render nothing: true
  end
end
