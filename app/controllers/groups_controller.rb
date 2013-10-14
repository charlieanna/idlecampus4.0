 require 'json'
class GroupsController < ApplicationController
  respond_to :json,:html
  def index
    @groups = current_user.groups
    respond_with @groups
  end

  def show
    @group = Group.find(params[:id])
     respond_with @group
  end

  def new
    @group = Group.new
  end

  def create
    # shout = current_user.shouts
    # @user = User.find(params[:user_id])
    # @user = User.find_by_jabber_id(params[:jid])
    puts params
     @group = current_user.groups.build
     
    @group.name = params[:group][:name]
     @group.group_code = params[:group][:code]
    @groups = current_user.groups
    # @group.group_code = get_group_code
    # put get_group_code inside models 
    #limit controller length 100. refactor the code into models and other objects. 
    group = {}
    group[:name] = @group.name
    group[:code] = @group.group_code
    
    flash[:group] = group
    # puts @group
    # @group.name
    # puts Group.count
    if @group.save
        # render :nothing => true, :status => 200, :content_type => 'text/html'
      # respond_to do |format|
      #      format.html
      #      format.js
      #    end
       redirect_to  current_user
    else
       render :nothing => true, :status => 200, :content_type => 'text/html'
    end
  end

  def edit
    @group = Group.find(params[:id])
  end

  def update
    @group = Group.find(params[:id])
    if @group.update_attributes(params[:group])
      flash[:notice] = "Successfully updated group."
      redirect_to group_url
    else
      render :action => 'edit'
    end
  end

  def destroy
    @group = Group.find(params[:id])
    @group.destroy
    flash[:notice] = "Successfully destroyed group."
    redirect_to galleries_url
  end

   def find_by_name1
   	p params
   	@group = Group.find_by_name(params["group"]);
    @folders = @group.folders
    p @folders
     respond_with @folders
    folders_hash = {}
    folder_hash = {}
    folder_hash["folder"] = @folders
    folders_hash["folders"] = folder_hash

    @folders_json = ActiveSupport::JSON.encode(folders_hash)

    render :json => @folders_json
   	
   end


   def find_by_name
    p params
    @group = Group.find_by_name(params["name"]);
    entries = @group.folders
    respond_with entries
   end

  def get_group_names
    p params
    mygroups = params["mygroups"]
    groupsfollowing = params["groupsfollowing"]
    if mygroups!=nil && groupsfollowing!=nil
    groups = mygroups + groupsfollowing
    elsif mygroups==nil && groupsfollowing!=nil
      groups =  groupsfollowing
    elsif mygroups!=nil && groupsfollowing==nil
      groups = mygroups
    end
    group_codes = []
    groups.each do |group|
      p group
      group_hash = {}
      group_hash["group_code"] = group
      group_hash["group_name"] = Group.find_by_group_code(group).name
      group_codes << group_hash
    end
    p group_codes
    @timetable = ActiveSupport::JSON.encode(group_codes)

    render :json => @timetable


  end
  #remove this. Instead send the whole object as a json and then create the group on the xmpp server.
  def  get_group_code
    groups = Group.all
    group_codes = []
    groups.each do |group|
      group_codes << group.group_code
    end
    p group_codes
    new_group_code = generate_group_code
    while group_codes.include? new_group_code
      new_group_code = generate_group_code
    end
    # return new_group_code
    render :text => new_group_code

  end


  def get_group_name
    group = Group.find_by_group_code(params[:group_code])

    if group


      group_hash = {}
      group_hash["group_name"] = group.name
      group_hash["group_code"] = group.group_code

    @group = ActiveSupport::JSON.encode(group_hash)

    render :json => @group

    else

      render :text => "group not found"

    end


  end
# Generates a random string from a set of easily readable characters
  def generate_group_code(size = 6)
    charset = %w{ 2 3 4 6 7 9 A C D E F G H J K M N P Q R T V W X Y Z}
    (0...size).map{ charset.to_a[rand(charset.size)] }.join
  end



end
