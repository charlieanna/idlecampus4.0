require 'ruby_bosh'
class SessionsController < ApplicationController
  respond_to :html, :js

  def new
  end

  def index

    sign_in_to_xmpp_with_password(User.new,"")
  end

  def create
    
    @user = User.find_by_email(params[:session][:email].downcase)
    
      jid = "cc@idlecampus.com"
      password = ""
       @client = Jabber::Client.new(jid)
       Jabber::debug = true
       @client.connect
       fields = {}
      
        @client.register("cc", fields)
       # @client.auth(password)
 #       @client.send(Jabber::Presence.new.set_type(:available))
    
   # if @user && @user.authenticate(params[:session][:password])
 #      @jabber_id = @user.jabber_id
 #      @password = params[:session][:password]
 #   
 #      sign_in @user
 # 
 # 
 # 
 #      attacher = {}
 #      attacher[:user] = @user.name
 #      attacher[:password] = params[:session][:password]
 #      
 #      flash[:attacher] = attacher
 #      redirect_to @user,:notice => "Welcome to IdleCampus"
 # 
 #    else
 # 
 # 
 #    flash.now[:error] = 'Invalid email/password combination'
 #      render 'new'
 #    end


  end


  def destroy
    sign_out
    redirect_to root_url

  end


end


