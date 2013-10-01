class UsersController < ApplicationController
  before_action :signed_in_user, only: [:show]
  before_action :correct_user,   only: [:show]
  def create

    @user = User.new(user_params)
    @user.password_confirmation = @user.password
    @user.email = params[:user][:email]
    @user.jabber_id = params[:jabber_id]
    @user.device_identifier = "#{params[:user][:name]}@idlecampus.com"
    password = params[:user][:password]
    name = params[:user][:name]
    email = params[:user][:email]
 #    @user.password_confirmation = params[:password]
    puts @user.valid?
    puts @user.errors.full_messages
    if @user.save


       sign_in @user

      p cookies

      @cookies = cookies


      flash[:success] = "Welcome to IdleCampus!"
      attacher = {}
      attacher[:name] = name
      
      attacher[:password] = password
      flash[:register] = attacher
      redirect_to @user

    else
      render 'new'
    end


  end


  def show
    @user = User.find(params[:id])

    gon.attacher = flash[:attacher]  unless flash[:attacher].nil?
    gon.register = flash[:register]  unless flash[:register].nil?

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

  def test

    users.each do |device_identifier|

      i = jabber_user.index('/')
      puts i
      if (i!=nil)
        jabber_user = jabber_user[0, i]
        puts jabber_user
      end
      user = User.find_by_jabber_id(jabber_user)
      if (user != nil)
        puts user
        device_identifier = user.device_identifier
        puts device_identifier
        device = Device.find_by_device_identifier(device_identifier)
        puts device
        send_push(device, message)
      end
    end
  end

  def checkEmail
    emails = User.where(:email => params["email"])
    render :text => emails.size
  end

  def checkName
    jabber_id = params["name"] + "@idlecampus.com"
    p jabber_id
    names = User.where(:jabber_id => jabber_id)
    render :text => names.size
  end


  def new
   
    @user = User.new
  end

  def send_push
    p params
    puser = params["users"]

    puser.slice!(puser.index('/'), puser.size)
    message = params["message"]
    devices = []
    user = User.find_by_jabber_id(puser)
    device = user.device_identifier
    devices << device

    timetable_hash = {}
    entries_hash = {}
    entries_hash["devices"] = devices
    entries_hash["message"] = message
    timetable_hash["push"] = entries_hash
    p timetable_hash
    @devices = ActiveSupport::JSON.encode(timetable_hash)

    p "CCCCCCCCCC"

    p request.fullpath
    p request.domain
    p request.base_url
    p request.original_fullpath

    puts "timetable push"

    uri = URI('http://developer.idlecampus.com/push/push1')
    p "UUUUUUUUUUURRRRRRRRRR"

    headers = {"Content-Type" => "application/json"}
    http = Net::HTTP.new(uri.host, uri.port)


    resp, dat = http.post(uri.path, timetable_hash.to_json, headers)
    render :nothing => true

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
