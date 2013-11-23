class HomesController < ApplicationController
  def show
    if signed_in?
      @group = Group.new(user: current_user)
      @group.group_code = Group.get_group_code
    end
  end
end