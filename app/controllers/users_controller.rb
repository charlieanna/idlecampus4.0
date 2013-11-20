require 'drb'
require 'basic_drb'
class UsersController < ApplicationController
  
 before_action :correct_user,   only: [:edit, :update]
  before_action :signed_in_user, only: [:edit, :update]
  def new
    @user = User.new
  end
  def create
  
    @group = Group.find_by(group_code:params["Group Code"])
    
    if params["Group Code"] 
      if @group 
      @user = User.new(user_params)
    
   
      @user.password_confirmation = @user.password
   
    
    
      @user.device_identifier = "web"
    
      @user.rolable_type = "Student"
   
   
    
    
      if @user.save
      
        TopfunkyIM.register(@user.name,@user.password)
      
        DRb.start_service("druby://localhost:7777", TopfunkyIM.new(@user.jabber_id,@user.password, nil, false))
   
        xmpp = DRbObject.new_with_uri "druby://localhost:7777"
      
        sign_in @user
        
       
        
        xmpp.subscribe(params["Group Code"] )

        # @group = current_user.groups.build
     

        @cookies = cookies
      
       


        flash[:success] = "Welcome to IdleCampus!"
     
        # flash[:register] = @user.to_hash

        redirect_to @group

      else
      
        render 'new'
      end
    else
      flash[:error] = "Group Not Found"
      redirect_to new_student_path
    end
    
    
     
    else
    
     
    
    @user = User.new(user_params)
    
    @user.rolable_type = "Teacher"
    @user.password_confirmation = @user.password
   
    
    
    @user.device_identifier = "web"
    
    
   
   
    
    
    if @user.save
      
      TopfunkyIM.register(@user.name,@user.password)
      
      DRb.start_service("druby://localhost:7777", TopfunkyIM.new(@user.jabber_id,@user.password, nil, false))
   
      xmpp = DRbObject.new_with_uri "druby://localhost:7777"
      
      sign_in @user

      # @group = current_user.groups.build
     

      @cookies = cookies
      
      @groups = current_user.groups


      flash[:success] = "Welcome to IdleCampus!"
     
      # flash[:register] = @user.to_hash
puts "DASDSADASD"
      redirect_to @user

    else
      
      render 'new'
    end
  end
    
end

 
  def show
    # puts "DASDSADASD"
     @note = Note.new
    
     @alert = Alert.new
    
     @user = current_user
     
  
   
     @groups = @user.groups
    
     @group = @user.groups.new
     @count = @groups.count
   
    
  end


  def login
    p params
    if (!params[:device_identifier].eql? "web")
      users_with_device = User.where(device_identifier: params[:device_identifier])
      users_with_device.each do |user|
        user.device_identifier = ""
        user.save
      end
  
  
    end
    user = User.find_by_jabber_id(params[:jabber_id])
    if (user)
      user.device_identifier = params[:device_identifier]
      user.save
    end
    render :nothing => true
  end
   


  def new
   
    @user = User.new
  end
  
  def send_push
    #  {"users"=>"zb@idlecampus.com", "message"=>"dsvdxv", "controller"=>"users", "action"=>"send_push"}
    members = []
    members.push(params["users"])
    args = {}
    args["members"] = members
    args["message"] = params["message"]
    args["app"] = "message"
    PygmentsWorker.perform_async(args)
    render text: "OK"
  end
  


  private 
  
  def user_params
    params.require(:user).permit(:name, :email, :password)
  end

  def signed_in_user
        redirect_to root_path, notice: "Please sign in." unless signed_in?
  end

  def correct_user
       @user = User.find(params[:id])
       redirect_to(root_url) unless current_user?(@user)
  end
end
