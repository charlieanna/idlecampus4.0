require 'ruby_bosh'
require 'drb'
require 'basic_drb'
class SessionsController < ApplicationController
  respond_to :html, :js

  def new
  end

  def index

    sign_in_to_xmpp_with_password(User.new,"")
  end

  def create
    
    @user = User.find_by_email(params[:session][:email].downcase)
    
    
#     DRb.thread.join
    
    
    
   if @user && @user.authenticate(params[:session][:password])
      @jabber_id = @user.jabber_id
      @password = params[:session][:password]
      
      sign_in @user
 
       DRb.start_service("druby://localhost:7777", TopfunkyIM.new(@jabber_id,@password, nil, false))
 
  
      redirect_to @user,:notice => "Welcome to IdleCampus"
 
    else
 
 
    flash.now[:error] = 'Invalid email/password combination'
      render 'new'
    end


  end


  def destroy
    xmpp = DRbObject.new_with_uri "druby://localhost:7777"
    xmpp.logout
    sign_out
    redirect_to root_url

  end


end


