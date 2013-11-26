class HomesController < ApplicationController
  def show
    puts params
    if signed_in? 
      gon.attacher = flash[:attacher]
      @group = Group.new(user: current_user) if current_user.rolable_type == "Teacher"
      if current_user.rolable_type == "Student"
        
        @group = current_user.following_groups.first
        gon.attacher[:group] = @group.group_code  
       
      end
    end
    
    gon.n = "sds"
  end
end