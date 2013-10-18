require '../spec_helper'

describe "User signup" do
	it "user should be able see signup page" do
	  visit "/"
	  click_link "Sign Up!"
	  expect(page).to have_css("h3",text:"Sign up for a free account")
  end

  it "user should be able to create an accout" do
  	visit '/'
  	click_link "Sign Up!"
  	fill_in "Name",with:"ankur kothari"
  	fill_in "Email",with:"ankothari@gmail.com"
  	fill_in "Password",with:"akk322"
  	
  	expect{click_button "Create Account"}.to change{User.count}.by(1)
  	# Capybara.default_wait_time = 15
   #  save_and_open_page
  end


end