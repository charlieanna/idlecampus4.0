module SessionsHelper

  def sign_in(user,password)
  	p "signing in"

    remember_token = User.new_remember_token

    user.update_attribute(:remember_token, User.encrypt(remember_token))
    self.current_user = user
    sign_in_to_xmpp_with_password(user,password)
    cookies.permanent[:remember_token] = remember_token
  end
  
  def sign_in(user)
  	p "signing in"

    remember_token = User.new_remember_token

    user.update_attribute(:remember_token, User.encrypt(remember_token))
    self.current_user = user
   
    cookies.permanent[:remember_token] = remember_token
  end

  def current_user=(user)
    @current_user = user
  end

  def signed_in?
    !current_user.nil?
  end
  
  def current_user?(user)
     user == current_user
   end

  def current_user
    remember_token = User.encrypt(cookies[:remember_token])
    @current_user ||= User.find_by(remember_token: remember_token)
    #debugger
    @attacher = sign_in_to_xmpp_as_user(@current_user)
    return @current_user
  end

  def sign_out
    self.current_user = nil
    cookies.delete(:remember_token)
    cookies.delete(:JID)
    cookies.delete(:SID)
    cookies.delete(:RID)
  end

def sign_in_to_xmpp_with_password(user,password)

     @session_jid, @session_id, @session_random_id =
         RubyBOSH.initialize_session(user.jabber_id, password, "http://54.254.135.165/http-bind")
     cookies[:JID] = @session_jid
     cookies[:SID] = @session_id
     cookies[:RID] = @session_random_id

end


 end



  def sign_in_to_xmpp_as_user(user)




      @session_jid = cookies[:JID]
      @session_id = cookies[:SID]
      @session_random_id = cookies[:RID]

      attacher = {}
      attacher[:JID] = @session_jid
      attacher[:SID] = @session_id
      attacher[:RID] = @session_random_id


      return attacher

  end