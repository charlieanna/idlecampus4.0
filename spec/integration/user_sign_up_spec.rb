require_relative '../spec_helper'

feature 'Visitor signs up', :js => true do
  before do
    @user = FactoryGirl.build(:user)
  end
  subject{page}
	it "first sees signup page" do
	  visit signup_path 
	  click_link "Sign Up!"
	  expect(page).to have_css("h3",text:"Sign up for a free account")
  end
 
  scenario 'with valid email and password' do
  puts @user.name
  
    sign_up_with(@user.name,@user.email,"akk322")
     
     expect(page).to have_content "Welcome #{@user.name}"     
     expect(page).to have_link('Sign out')    
     
  end
 # 
 #         
  scenario 'with invalid email'  do
    sign_up_with "sdsdsad",'invalid_email', 'password'
 
    expect(page).to have_css("h3",text:"Sign up for a free account")
  end
 
  scenario 'with blank password' do
    sign_up_with "asdasd",'valid@example.com', ''
 
    expect(page).to have_css("h3",text:"Sign up for a free account")
  end 
  
      






end


   