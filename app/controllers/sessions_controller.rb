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
    
     DRb.start_service("druby://localhost:7777", TopfunkyIM.new("a@idlecampus.com","a", nil, false))
#     DRb.thread.join
    
    
    
   if @user && @user.authenticate(params[:session][:password])
      @jabber_id = @user.jabber_id
      @password = params[:session][:password]
   
      sign_in @user
 
      jid =  @jabber_id
      password = params[:session][:password]
      @client = Jabber::Client.new(jid)
      Jabber::debug = true
      @client.connect
      
      @client.auth(password)
      @client.send(Jabber::Presence.new.set_type(:available))
 
      # attacher = {}
#       attacher[:user] = @user.name
#       attacher[:password] = params[:session][:password]
#       
#       flash[:attacher] = attacher
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


