class TeachersController < ApplicationController
  def new
    @user = User.new
    @user.rolable_type= "Teacher"
   render 'users/new'
  end
  
  
end
