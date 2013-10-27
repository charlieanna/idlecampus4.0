require_relative '../spec_helper'

feature 'Visitor signs up' do
  before { visit signup_path }
  subject{page}
	it "first sees signup page" do
	  visit signup_path
	  click_link "Sign Up!"
	  expect(page).to have_css("h3",text:"Sign up for a free account")
  end

  scenario 'with valid email and password' do
  	sign_up_with("ankur kothari","ankothari@gmail.com","akk322")
  	
     expect(page).to have_content "Welcome ankur kothari"
    expect(page).to have_link('Sign out')    
       
  end

        
     scenario 'with invalid email' do
    sign_up_with "sdsdsad",'invalid_email', 'password'

     expect(page).to have_css("h3",text:"Sign up for a free account")
  end

  scenario 'with blank password' do
    sign_up_with "asdasd",'valid@example.com', ''

     expect(page).to have_css("h3",text:"Sign up for a free account")
  end 
  
      






end


    def sign_up_with(name,email,password)
      visit signup_path
    fill_in "Name",with:name
    fill_in "Email",with:email
    fill_in "Password",with:password
    click_button "Create Account"
   
   
    end