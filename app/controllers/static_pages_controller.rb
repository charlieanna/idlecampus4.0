class StaticPagesController < ApplicationController
  # before_filter :check_logged_in_user
  
  def home
     if signed_in?
       @group  = current_user.groups.build
       
     end
   end

  def contact
  end

  def about
  end


  # private 
 #   
 #    def check_logged_in_user
 # 
 #      if signed_in?
 #        redirect_to current_user
 #      end
 #    end
end
