class DevicesController < ApplicationController
  respond_to :json
  before_filter :find_user
  def create
    p params
    if (!params[:device_identifier].eql? "web")
      users_with_device = User.where(device_identifier: params[:device_identifier])
      users_with_device.each do |user|
        user.device_identifier = ""
        user.save
      end


    end
    
    if (@user)
      @user.device_identifier = params[:device_identifier]
      @user.save
    end
  end
  
  private 
  
  def find_user
    @user = User.find_by_jabber_id(params[:jabber_id])
  end
end