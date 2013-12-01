require_relative '../spec_helper'

feature 'Student Sign up' do
 
  describe "after the teachers has created a group"
  

  
  it "signs up with the group" do
    @user = FactoryGirl.create(:user)
    group = Group.create(name:'Electronics')
    user = FactoryGirl.build(:user) 
    sign_up_with_student(group.group_code,user.name,user.email,"akk322")
    page.should have_css "h1",user.name  
    page.should have_css "h3","Notes"    
    expect(page).to have_link('Sign out')  
  end
     


end


   