class TeachersController < ApplicationController
  def new
    @user = User.new
    @user.rolable_type= "Teacher"
    
  end
end
