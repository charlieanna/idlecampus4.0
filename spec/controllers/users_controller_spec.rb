require 'spec_helper'

describe UsersController do
  describe "#send_push" do
    it "sends a message" do
      #  {"users"=>"zb@idlecampus.com", "message"=>"dsvdxv", "controller"=>"users", "action"=>"send_push"}
      post :send_push,message: "sdadas",users: "zb@idlecampus.com"
    end
    
    
  end
end