require 'ruby_bosh'
#SessionsController
class SessionsController < ApplicationController
  respond_to :html, :js

  def new
    gon.n = ""
  end

  def create
    @user = User.find_by_email(params[:session][:email].downcase)
    if @user && @user.authenticate(params[:session][:password])
      @session_jid, @session_id, @session_random_id = 
      RubyBOSH.initialize_session(@user.jabber_id, params[:session][:password], "http://idlecampus.com:5280/http-bind")
      attacher = {}
      attacher[:jid] = @session_jid
      attacher[:id] = @session_id
      attacher[:rid] = @session_random_id
    
      flash[:attacher] = attacher
      
      sign_in @user
      flash[:success] = 'Welcome back to IdleCampus!'
      redirect_to home_path
    else
      flash[:error] = 'Invalid email/password combination'
      redirect_to signin_path
    end
  end

  def destroy
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
