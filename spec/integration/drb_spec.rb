require_relative '../spec_helper'

describe "testing drb" do
  it "by creating a teacher and then a student" do
    user1 = FactoryGirl.build(:user)
    sign_up_with(user1.name,user1.email,"akk322")
    group = FactoryGirl.create(:group,:group_code=>"A6J4ZQ")
    click_link "Sign out"
    user = FactoryGirl.build(:user)
   
    sign_up_with_student(group.group_code,user.name,user.email,"akk322")
    click_link "Sign out"
    user = FactoryGirl.build(:user)
   
    sign_up_with_student(group.group_code,user.name,user.email,"akk322")
    click_link "Sign out"
    user = FactoryGirl.build(:user)
   
    sign_up_with_student(group.group_code,user.name,user.email,"akk322")
    click_link "Sign out"
    user = FactoryGirl.build(:user)
   
    sign_up_with_student(group.group_code,user.name,user.email,"akk322")
    
  end
end