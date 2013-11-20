class StudentsController < UsersController
  def new
    @user = User.new
    @user.rolable_type = "Student"
    render 'users/new'
  end
  
  def create
    @group = Group.find_by(group_code:params[:student][:following_group])
    
    if @group
      super
      xmpp = DRbObject.new_with_uri "druby://localhost:7777"
      xmpp.subscribe(@group)
      @user.type = "Student"
      
    
    else
     
      flash[:error] = "Group Not Found"
      redirect_to new_student_path
    end
    
  end
end
