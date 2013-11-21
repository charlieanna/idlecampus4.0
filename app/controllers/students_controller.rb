class StudentsController < UsersController
  def new
    @user = User.new
    @user.rolable_type = "Student"
    render 'users/new'
  end
  
 
end
