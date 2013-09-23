module SessionsHelper

  def sign_in(user,session_jid, session_id, session_random_id)
  	p "signing in"
  	
    cookies.permanent[:remember_token] = user.remember_token
    cookies[:session_jid] = session_jid
    cookies[:session_id] = session_id
    cookies[:session_random_id] = session_random_id
  
    self.current_user = user
  end

  def current_user=(user)
   @current_user ||= User.find_by_remember_token(cookies[:remember_token])
  end

  def signed_in?
    !current_user.nil?
  end

  def sign_out
    self.current_user = nil
    cookies.delete(:remember_token)
    cookies.delete(:session_jid)
    cookies.delete(:session_id)
    cookies.delete(:session_random_id)
  end
end