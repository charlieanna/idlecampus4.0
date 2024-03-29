class PasswordResetsController < ApplicationController
  def new
  end
  
  def create
    user = User.find_by_email(params[:email])
    if user
      user.send_password_reset if user
      redirect_to root_url, :notice => "Email sent with password reset instructions."
    else
      redirect_to root_url, :notice => "User not found."
    end
  end
  
  def edit
    @user = User.find_by_password_reset_token!(params[:id])
  end
  
  def update
    if params[:password] != params[:confirmation_password]
      
    end
    @user = User.find_by_password_reset_token!(params[:id])
    if @user.password_reset_sent_at < 2.hours.ago
      redirect_to new_password_reset_path, :alert => "Password &crarr; 
        reset has expired."
    elsif @user.update_attributes(params.require(:user).permit(:password, :password_confirmation))
      redirect_to signin_path, :notice => "Password has been reset."
    else
      render :edit
    end
  end
end
