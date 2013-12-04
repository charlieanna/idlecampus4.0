#
require 'drb'
require 'basic_drb'
require 'ruby_bosh'
class UsersController < ApplicationController
  protect_from_forgery except: :login
  before_action :correct_user, only: [:edit, :update]
  before_action :signed_in_user, only: [:edit, :update]

  def new
    @user = User.new
  end 

  def create
    @user = User.new(user_params)
    @group = Group.find_by(group_code: params['Group Code'])
    if params['Group Code']
      if @group
        if @user.save
          begin
             t = TopfunkyIM.register(@user.name, @user.password)
          rescue
            flash[:error] = "Student already present"
            gon.n = ""
            redirect_to students_signup_path
            return
          end
          @session_jid, @session_id, @session_random_id = 
          RubyBOSH.initialize_session(@user.jabber_id, @user.password, "http://idlecampus.com:5280/http-bind")
          attacher = {}
          attacher[:jid] = @session_jid
          attacher[:id] = @session_id
          attacher[:rid] = @session_random_id
          attacher[:group] = @group.group_code
          @user.follow(@group)
          flash[:attacher] = attacher
          UserMailer.signup_confirmation(@user).deliver
          sign_in_with_redirect(@user)
        else
          gon.n = ""
          render 'new'
        end
      else
        flash[:error] = 'Group Not Found'
        redirect_to students_signup_path
      end
    else
      if @user.save
       begin
           t = TopfunkyIM.register(@user.name, @user.password)
        rescue
          flash[:error] = "Teacher already present"
          gon.n = ""
          redirect_to teachers_signup_path
          return
        end
       
        
        @session_jid, @session_id, @session_random_id = 
        RubyBOSH.initialize_session(@user.jabber_id, @user.password, "http://idlecampus.com:5280/http-bind")
        attacher = {}
        attacher[:jid] = @session_jid
        attacher[:id] = @session_id
        attacher[:rid] = @session_random_id
      
        flash[:attacher] = attacher
        sign_in_with_redirect(@user)
      else
        render 'new'
      end
    end
  end

  def show
    @user = User.find(params[:id])
   
  end

  

  def login
    update_all_users_who_are_not_web_to_device_identifier_as_blank
    user = User.find_by_jabber_id(params[:jabber_id])
    user.update(device_identifier: params[:device_identifier])
    render nothing: true
  end

  def send_push
    #  {"users"=>"zb@idlecampus.com", "message"=>"dsvdxv", "controller"=>"users", "action"=>"send_push"}
    members = [params['to']]
    args = { members: members, message: params['message'], app: 'message' }
    PygmentsWorker.perform_async(args)
    render text: 'OK'
  end

  private
  
  def update_all_users_who_are_not_web_to_device_identifier_as_blank
    unless params[:device_identifier].eql? 'web'
      User.where(device_identifier: params[:device_identifier]).update_all(device_identifier: '')
    end
  end

  def sign_in_with_redirect(user)
    sign_in @user
    flash[:success] = 'Welcome to IdleCampus!'
    redirect_to home_path
  end

  def start_service(user, options = {})
     
     
  #   t = TopfunkyIM.new(@user.jabber_id, @user.password, nil, false)
  #   DRb.start_service('druby://localhost:7777', t)
  #   xmpp = DRbObject.new_with_uri 'druby://localhost:7777'
  #   xmpp.subscribe(params['Group Code']) if options[:group]
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :rolable_type)
  end

  def signed_in_user
    redirect_to root_path, notice: 'Please sign in.' unless signed_in?
  end

  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless current_user?(@user)
  end
end
