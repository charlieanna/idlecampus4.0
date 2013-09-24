module SessionsHelper

  def sign_in(user,password)
  	p "signing in"

    remember_token = User.new_remember_token

    user.update_attribute(:remember_token, User.encrypt(remember_token))
    self.current_user = user
    sign_in_to_xmpp_with_password(user,password)
    cookies.permanent[:remember_token] = remember_token
  end

  def current_user=(user)
    @current_user = user
  end

  def signed_in?
    !current_user.nil?
  end

  def current_user
    remember_token = User.encrypt(cookies[:remember_token])
    @current_user ||= User.find_by(remember_token: remember_token)
    sign_in_to_xmpp_as_user(@current_user)
  end

  def sign_out
    self.current_user = nil
    cookies.delete(:remember_token)
    cookies.delete(:session_jid)
    cookies.delete(:session_id)
    cookies.delete(:session_random_id)
  end

def sign_in_to_xmpp_with_password(user,password)

     @session_jid, @session_id, @session_random_id =
         RubyBOSH.initialize_session(user.jabber_id, password, "http://idlecampus.com/http-bind")

     attacher = {}
     attacher[:JID] = @session_jid
     attacher[:SID] = @session_id
     attacher[:RID] = @session_random_id
     gon.attacher = attacher
end


 end



  def sign_in_to_xmpp_as_user(user)




      @session_jid = cookies[:session_jid]
      @session_id = cookies[:session_id]
      @session_random_id = cookies[:session_random_id]

      attacher = {}
      attacher[:JID] = @session_jid
      attacher[:SID] = @session_id
      attacher[:RID] = @session_random_id
      gon.attacher = attacher



  end