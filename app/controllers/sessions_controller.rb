#
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
      xmpp.login(@user.jabber_id,params[:session][:password])
      flash[:success] = 'Welcome to IdleCampus!'
      
        redirect_to home_path
      
    
    else
      flash.now[:error] = 'Invalid email/password combination'
      render 'new'
    end
  end

  def destroy
    xmpp = DRbObject.new_with_uri 'druby://localhost:7777'
    xmpp.logout
    sign_out
    redirect_to root_url
  end
  
  private

    def return_to
      session[:return_to] || params[:return_to]
    end

    def url_after_create
      if current_user.admin?
        admin_path
      else
        dashboard_path
      end
    end
    
    
end
