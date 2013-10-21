class UserValidationsController < ApplicationController
	 def checkEmail
    emails = User.where(:email => params["email"])
    render :text => emails.size
  end
  # 
  def checkName
    name = params["name"]
 
    names = User.where(:name => name)
    render :text => names.size
  end

end
