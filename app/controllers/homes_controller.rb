class HomesController < ApplicationController
  def show
    if signed_in? 
      gon.attacher = flash[:attacher]
      @group = Group.new(user: current_user)
      if current_user.rolable_type == "Teacher"
        
        groups = current_user.groups
        total_posts = []
        groups.each do |group| 
          posts = group.alerts.includes(:group)+ group.notes.includes(:group)
          
          total_posts <<  posts
        end 
        @posts = total_posts.flatten
        @posts = @posts.sort_by(&:created_at).reverse
      elsif current_user.rolable_type == "Student"
       
          @group = current_user.all_following.first  
          @posts = []
          @posts << @group.alerts
          @posts << @group.notes
          @posts.flatten!
       
          @posts = @posts.sort_by(&:created_at).reverse
       
     
       
      end
      
    end
  end
end