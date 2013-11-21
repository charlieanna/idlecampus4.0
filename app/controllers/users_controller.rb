require 'drb'
require 'basic_drb'
class UsersController < ApplicationController

  before_action :correct_user, only: [:edit, :update]
  before_action :signed_in_user, only: [:edit, :update]

  def new
    @user = User.new
  end

  def create


    @user = User.new(user_params)

    @group = Group.find_by(group_code: params["Group Code"])


    if params["Group Code"]

      if @group


        if @user.save


          sign_in @user

          start_service(@user, group: params["Group Code"])

          flash[:success] = "Welcome to IdleCampus!"

          redirect_to @group

        else

          render 'new'
        end
      else
        flash[:error] = "Group Not Found"
        redirect_to new_student_path
      end


    else


      if @user.save

        sign_in @user

        start_service(@user)

        flash[:success] = "Welcome to IdleCampus!"


        redirect_to @user

      else

        render 'new'
      end
    end

  end


  def show
    
    @user = User.find(params[:id])
    
    @groups = @user.groups

    @group = @user.groups.new
  
  end

  def update_all_users_who_are_not_web_to_device_identifier_as_blank
    if (!params[:device_identifier].eql? "web")


      User.where(device_identifier: params[:device_identifier]).update_all(device_identifier: '')


    end
  end


  def login

    update_all_users_who_are_not_web_to_device_identifier_as_blank
    user = User.find_by_jabber_id(params[:jabber_id])
    user.update(device_identifier: params[:device_identifier])
 
    render nothing: true
  end


  def new

    @user = User.new
  end

  def send_push
    #  {"users"=>"zb@idlecampus.com", "message"=>"dsvdxv", "controller"=>"users", "action"=>"send_push"}
    members = [params["users"]]
   
    args = {:"members" => members,:"message"=> params["message"],:"app"=> "message"}
   
    PygmentsWorker.perform_async(args)
    render text: "OK"
  end


  private

  def start_service(user, options = {})
    TopfunkyIM.register(@user.name, @user.password)

    DRb.start_service("druby://localhost:7777", TopfunkyIM.new(@user.jabber_id, @user.password, nil, false))

    xmpp = DRbObject.new_with_uri "druby://localhost:7777"

    xmpp.subscribe(params["Group Code"]) if options[:group]
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :rolable_type)
  end

  def signed_in_user
    redirect_to root_path, notice: "Please sign in." unless signed_in?
  end

  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless current_user?(@user)
  end
end
