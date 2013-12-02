class HomesController < ApplicationController
  def show
    if signed_in? 
      gon.attacher = flash[:attacher]
      if current_user.rolable_type == "Teacher"
        @group = Group.new(user: current_user)
        groups = current_user.groups
        total_posts = []
        groups.each do |group| 
          posts = group.alerts.includes(:group)+ group.notes.includes(:group)
          
          total_posts <<  posts
        end 
        @posts = total_posts.flatten
        @posts = @posts.sort_by(&:created_at).reverse
      elsif current_user.rolable_type == "Student"
        
       
        gon.attacher[:group] = @group.group_code if gon.attacher = flash[:attacher]
       
      end
      
    end
  end
end