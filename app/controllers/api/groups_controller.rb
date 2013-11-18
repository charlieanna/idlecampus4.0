class Api::GroupsController < ApplicationController
	respond_to :json
  def show
    @group = Group.find_by_group_code(params[:id])
   
    if @group
     render :json => @group
   else 
     render text: "group not found"
   end
  end   
end