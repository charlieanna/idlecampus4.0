require "spec_helper"

describe "Groups" do

  it "signed in user should be able to create a group" do
    user = FactoryGirl.create(:user)
	  visit '/'
	  click_link "Log In"

	  fill_in "session_email",with: user.email
	  fill_in "session_password",with:user.password
	  
	  within("#login-content") do
	  
     click_button "Login"
     
	   
    end
     fill_in "group_name", with: "Electronics"
     

     # expect{click_button "Create"}.to change{user.groups.count}.by(1)
     expect{click_button "Create Group"}.to change{user.groups.count}.by(1)
  end	

  it "signed in user should be able see the groups he has created" do
    user = FactoryGirl.create(:user)
	  visit '/'
	  click_link "Log In"

	  fill_in "session_email",with: user.email
	  fill_in "session_password",with:user.password
	  
	  within("#login-content") do
	  
     click_button "Login"
     
	   
    end

    group1 = FactoryGirl.create(:group,user: user)
    group2 = FactoryGirl.create(:group,user: user)
    puts user.groups.first.name   
    expect(page).to have_css "ul#sidebar li"
    # expect(page).to have_css "ul#groupscreated li",text:group2.name

  end
end