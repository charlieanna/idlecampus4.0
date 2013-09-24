module SessionsHelper

  def sign_in(user,password)
  	p "signing in"

    remember_token = User.new_remember_token

    user.update_attribute(:remember_token, User.encrypt(remember_token))
    self.current_user = user
    sign_in_to_xmpp(user,password)
    cookies.permanent[:remember_token] = remember_token
  end

  def current_user=(user)
   @current_user ||= User.find_by_remember_token(cookies[:remember_token])
  end

  def signed_in?
    !current_user.nil?
  end

  def current_user
    remember_token = User.encrypt(cookies[:remember_token])
    @current_user ||= User.find_by(remember_token: remember_token)

  end

  def sign_out
    self.current_user = nil
    cookies.delete(:remember_token)
    cookies.delete(:session_jid)
    cookies.delete(:session_id)
    cookies.delete(:session_random_id)
  end

 def sign_in_to_xmpp(user,password)



   if cookies[:remember_token].present?

   else
   @session_jid, @session_id, @session_random_id =
       RubyBOSH.initialize_session(user.jabber_id, password, "http://idlecampus.com/http-bind")

   p "UUUUUUUUUU"
   p @session_id
   p @session_jid
   p @session_random_id
     debugger
   end
 end
end