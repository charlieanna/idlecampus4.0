require_relative '../spec_helper'

describe "View Group" do
	it "When the user clicks on the group he should see the group code and the timetable" do
    
	  user = FactoryGirl.build(:user)
    sign_up_with(user.name,user.email,"akk322")
    click_link "Sign out"
	  visit '/'
	  click_link "Log In"

	  fill_in "session_email",with: user.email
	  fill_in "session_password",with:user.password
	  
	  within("#login-content") do
	  
     click_button "Login"
     
	   
    end

    group1 = FactoryGirl.build(:group)
    
    fill_in "group",with:group1.name
   
   
    click_button "Create"
    
    
    
    click_link group1.name 
    expect(page).to have_css "#groupname",text:group1.name
    expect(page).to have_css "#groupcode",text:group1.code
  end
end