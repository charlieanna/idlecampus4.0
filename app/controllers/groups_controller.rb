require 'json'
require "xmpp4r"

require "xmpp4r/pubsub"
require "xmpp4r/pubsub/helper/servicehelper.rb"
require "xmpp4r/pubsub/helper/nodebrowser.rb"
require "xmpp4r/pubsub/helper/nodehelper.rb"
class GroupsController < ApplicationController
  respond_to :json,:html
  before_action :signed_in_user, only: [:create, :destroy]
  def index
    @groups = current_user.groups
    respond_with @groups
  end

  def show
    @group = Group.find_by_group_code(params[:id])
    @note = @group.notes.build
    
    
    
  
  end   


  def new
    @group = Group.new
  end

  def create
   
    # pubsub.create_node('home/localhost/pub/updates')
    xmpp = DRbObject.new_with_uri "druby://localhost:7777"
    
   
    
    @group = current_user.groups.build
    
    @group.name = params[:group][:name]
 
    @group.group_code = params[:group][:group_code] || Group.get_group_code
    
    xmpp.create_group(@group.group_code)
    
    
    
    
   
    if @group.save
     
      flash[:success] = "Group created!"
      # redirect_to root_url
        
    else
      render 'static_pages/home'
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
end
