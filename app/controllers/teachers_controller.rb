#
class TeachersController < ApplicationController
  def new
    @user = User.new
    @user.rolable_type= "Teacher"
    gon.num = ""
    render 'users/new'
  end
end
