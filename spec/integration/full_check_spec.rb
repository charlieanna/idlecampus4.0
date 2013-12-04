require 'spec_helper'

describe "The teacher signs up" do
  it "sign up" do
    user = FactoryGirl.build(:user)
    visit '/'
    click_button "Sign up As Teacher!"
    sign_up_with(@user.name,@user.email,"akk322")
    
  end
end