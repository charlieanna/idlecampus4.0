require 'ruby_bosh'
require 'drb'
require 'basic_drb'
class SessionsController < ApplicationController
  respond_to :html, :js

  def new
  end

  def create
    @user = User.find_by_email(params[:session][:email].downcase)
    if @user && @user.authenticate(params[:session][:password])
      sign_in @user
      t = TopfunkyIM.new(@user.jabber_id, params[:session][:password], nil, false)
      DRb.start_service('druby://localhost:7777', t)
      redirect_to @user, notice: 'Welcome to IdleCampus'
    else
      flash.now[:error] = 'Invalid email/password combination'
      render 'new'
    end
  end

  def destroy
    xmpp = DRbObject.new_with_uri 'druby://localhost:7777'
    xmpp.logout
    DRb.stop_service
    sign_out
    redirect_to root_url
  end
end
