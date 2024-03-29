require 'json'
require 'xmpp4r'
require 'xmpp4r/pubsub'
require 'xmpp4r/pubsub/helper/servicehelper.rb'
require 'xmpp4r/pubsub/helper/nodebrowser.rb'
require 'xmpp4r/pubsub/helper/nodehelper.rb'
# GroupsController.rb
class GroupsController < ApplicationController
  respond_to :json, :html
  before_action :signed_in_user, only: [:create, :destroy,:show]
  def index
    @groups = current_user.groups
    respond_with @groups
  end

  def show
    @group = Group.find(params[:id])
    gon.a = ""
    @posts = @group.alerts.includes(:group) + @group.notes.includes(:group)
    @posts = @posts.sort_by(&:created_at).reverse
      # @posts = Kaminari.paginate_array(@posts).page(params[:page]).per(5)
  end

  def new
    @group = Group.new
    @group.group_code = Group.get_group_code
  end

  def create
    @group = current_user.groups.build(name:params[:group][:name])
    # @group.group_code = Group.get_group_code
    
    @group.save
  end

  def edit
    @group = Group.find(params[:id])
  end

  def update
    xmpp = DRbObject.new_with_uri 'druby://localhost:7777'
    @group = current_user.groups.build
    @group.name = params[:group][:name]
    @group.group_code = Group.get_group_code
    xmpp.create_group(@group.group_code)
    if @group.save
      puts @group.group_code
    else
      render 'static_pages/home'
    end
  end

  def destroy
    @group = Group.find(params[:id])
    @group.destroy
    flash[:notice] = 'Successfully destroyed group.'
    redirect_to galleries_url
  end
end
