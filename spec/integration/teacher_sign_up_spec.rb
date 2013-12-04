require_relative '../spec_helper'

feature 'Sign up', :js => true do
  before do
    @user = FactoryGirl.build(:user)
    
  end
  
  subject{page}
   scenario "and sees signup page" do
     visit teachers_signup_path 
     click_link "Sign Up As Teacher!"
     expect(page).to have_css("h3",text:"Sign up for a free account")
  end
 
   context "and signs up" do
    scenario 'with valid email and password' do
      sign_up_with(@user.name,@user.email,"akk322")
      page.should have_css "h1",@user.name    
      expect(page).to have_link('Sign out')   
      click_link "Sign out"
   end
#   
#  
#          
  scenario 'with invalid email'  do
    sign_up_with "sdsdsad",'invalid_email', 'password'
 
    expect(page).to have_css("h3",text:"Sign up for a free account")
  end
#  
  scenario 'with blank password' do
    sign_up_with "asdasd",'valid@example.com', ''
 
    expect(page).to have_css("h3",text:"Sign up for a free account")
  end 
  scenario 'with valid email and password, logs out' do
 
 
     sign_up_with(@user.name,@user.email,"akk322")
   
     page.should have_css "h1",@user.name     
     expect(page).to have_link('Sign out')   
   
   
    
     click_link "Sign out"
    
     expect(page).to have_css "a",text:"Log In"
     
     
    
   
  end

 end


end


   