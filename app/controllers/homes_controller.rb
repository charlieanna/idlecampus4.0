class HomesController < ApplicationController
  def show
    puts params
    if signed_in? 
      @group = Group.new(user: current_user) if current_user.rolable_type == "Teacher"
      if current_user.rolable_type == "Student"
        xmpp = DRbObject.new_with_uri 'druby://localhost:7777'
        group = xmpp.get_subscriptions_from_all_nodes
        @group = Group.find_by(group_code: group[0].node) 
       
       
      end
    end
  end
end