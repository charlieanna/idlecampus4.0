module SessionsHelper

  def sign_in(user,password)


    remember_token = User.new_remember_token

    user.update_attribute(:remember_token, User.encrypt(remember_token))
    self.current_user = user
    sign_in_to_xmpp_with_password(user,password)
    cookies.permanent[:remember_token] = remember_token
  end
  
  def sign_in(user)
    

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
    return @current_user
  end

  def sign_out
    self.current_user = nil
    cookies.delete(:remember_token)
    cookies.delete(:JID)
    cookies.delete(:SID)
    cookies.delete(:RID)
  end
  
  
  def signed_in_user
      unless signed_in?
        # store_location
        redirect_to signin_url, notice: "Please sign in."
      end
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