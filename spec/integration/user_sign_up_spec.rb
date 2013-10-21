require_relative '../spec_helper'

describe "signup" do
  before { visit signup_path }
  subject{page}
	it "user should be able see signup page" do
	  
	  click_link "Sign Up!"
	  expect(page).to have_css("h3",text:"Sign up for a free account")
  end

  it "user should be able to create an accout" do
  	
  	click_link "Sign Up!"
  	fill_in "Name",with:"ankur kothari"
  	fill_in "Email",with:"ankothari@gmail.com"
  	fill_in "Password",with:"akk322"
  	
  	expect{click_button "Create Account"}.to change{User.count}.by(1)
    expect(page).to have_content "Welcome ankur kothari"
    expect(page).to have_link('Sign out') 
       
       
  end

        
       
      



   describe "with invalid information" do
      it "should not create a user" do
        expect { click_button "Create Account" }.not_to change(User, :count)
      end
    end


end