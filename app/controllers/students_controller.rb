class StudentsController < UsersController
  def new
    @user = Student.new
  end
  
  def create
    @group = Group.find_by(group_code:params[:student][:group])
    
    if @group
      super
      xmpp = DRbObject.new_with_uri "druby://localhost:7777"
      xmpp.subscribe(@group)
    
    else
     
      flash[:error] = "Group Not Found"
      redirect_to new_student_path
    end
    
  end
end
