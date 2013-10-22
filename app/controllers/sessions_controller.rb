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
    
   if  @user && @user.authenticate(params[:session][:password])
      @jabber_id = @user.jabber_id
      @password = params[:session][:password]
      #@session_jid, @session_id, @session_random_id =
      #    RubyBOSH.initialize_session(@jabber_id, @password, "http://idlecampus.com/http-bind")
      sign_in @user



      attacher = {}
      attacher[:user] = @user.name
      attacher[:password] = params[:session][:password]
      
      flash[:attacher] = attacher
      redirect_to @user,:notice => "Welcome to IdleCampus"

    else


    flash.now[:error] = 'Invalid email/password combination'
      render 'new'
    end


  end


  def destroy
    sign_out
    redirect_to root_url

  end


end



#p "QWEQWEWQEWQEQW"
#p cookies

#@session_jid, @session_id, @session_random_id =
#    RubyBOSH.initialize_session(@jabber_id, @password, "http://idlecampus.com/http-bind")

#debugger
#p "UUUUUUUUUU"
#p @session_id
#p @session_jid
#p @session_random_id
#
#cookies[:session_jid] = @session_jid  if @session_jid.present?
#cookies[:session_id] = @session_id if @session_id.present?
#cookies[:session_random_id] = @session_random_id    if @session_random_id.present?
#p cookies
#
#@cookies = cookies
## redirect_to user
# else
#    flash[:error] = 'Invalid email/password combination' # Not quite right!
#     render 'new'
# end

#@assignment = Assignment.new
# @assignment.save

#@note = Note.new

# @note.save
# user.notes << @note
# user.assignments << @assignment
# user.save
#   <li><%= link_to "<div class='box'><span><i class='icon-briefcase icon-white'></i></span>Developer</div>".html_safe, :controller => :developers, :action => :show %></li>

#render :initbosh

#  redirect_to :back, :flash => {:error => 'Invalid email/password combination'}
#end

#if user && user.authenticate(params[:session][:password])