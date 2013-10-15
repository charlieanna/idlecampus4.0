require "spec_helper"

describe "View Group" do
	it "When the user clicks on the group he should see the group code and the timetable" do
	  user = FactoryGirl.create(:user)
	  visit '/'
	  click_link "Log In"

	  fill_in "session_email",with: user.email
	  fill_in "session_password",with:user.password
	  
	  within("#login-content") do
	  
     click_button "Login"
     
	   
    end

    group1 = FactoryGirl.create(:group,user: user)
    click_link group1.name 
    expect(page).to have_css "#groupname",text:group1.name
    expect(page).to have_css "#groupcode",text:group1.code
  end
end