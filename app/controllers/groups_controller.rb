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
  
    @group = current_user.groups.build
    
    
     
    @group.name = params[:group][:name]
 
    @groups = current_user.groups
    @group.group_code = @group.get_group_code
    
    group = {}
    group[:name] = @group.name
    group[:code] = @group.group_code
    
    flash[:group] = group
   
    if @group.save
     
      respond_with @group
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
end
