class HomesController < ApplicationController
  def show
    if signed_in? 
      gon.attacher = flash[:attacher]
      @group = Group.new(user: current_user)
      if current_user.rolable_type == "Teacher"
        
        groups = current_user.groups
        total_posts = []
        alerts = []
       
        @posts = current_user.alerts + current_user.notes
        # debugger
        @posts = @posts.flatten
        @posts = @posts.sort_by(&:created_at).reverse
       
        @results = Kaminari.paginate_array(@posts).page(params[:page]).per(5)
      elsif current_user.rolable_type == "Student"
      
          @group = current_user.all_following.first 
          @posts = []
          @posts << @group.alerts.includes(:group)
          @posts << @group.notes.includes(:group)
          @posts.flatten!
       
          @posts = @posts.sort_by(&:created_at).reverse
         
        @posts = Kaminari.paginate_array(@posts).page(params[:page]).per(5)
     
       
      end
      
    end
  end
end