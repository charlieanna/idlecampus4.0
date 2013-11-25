#
class StudentsController < UsersController
  def new
    @user = User.new
    @user.rolable_type = "Student"
    gon.num = ""
    render 'users/new'
  end
end
