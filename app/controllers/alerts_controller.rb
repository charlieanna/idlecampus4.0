class AlertsController < ApplicationController
  def new
    @alert = Alert.new
  end

  def create
    group = Group.find_by(group_code: params[:alert][:group])
    @alert = group.alerts.build(message:params[:alert][:message])
    @alert.save
  end
end
