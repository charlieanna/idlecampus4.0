class StaticPagesController < ApplicationController
  def home
     if signed_in?
       @group  = current_user.groups.build
       
     end
   end

  def contact
  end

  def about
  end
end
