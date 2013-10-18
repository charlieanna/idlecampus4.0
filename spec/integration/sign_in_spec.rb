require_relative '../spec_helper'

describe "Sign in" do
   before(:all) do
    Capybara.current_driver = :webkit
  end
	it "user should be able to sign in" do
		user = FactoryGirl.create(:user)
	  visit '/'
	  click_link "Log In"

	  fill_in "session_email",with: user.email
	  fill_in "session_password",with:user.password
	  
	  within("#login-content") do
	  
     click_button "Login"
     
	   
    end
    expect(page).to have_content "Welcome #{user.name}"
  end

  
end
