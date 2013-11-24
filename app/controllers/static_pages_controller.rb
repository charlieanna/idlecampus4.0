#
class StaticPagesController < ApplicationController
  def home
     if signed_in?
       @group = Group.new(user: current_user)
       @group.group_code = Group.get_group_code
     end
     gon.product = ""
   end

  def contact
  end

  def about
  end
end
