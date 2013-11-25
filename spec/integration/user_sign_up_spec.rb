require_relative '../spec_helper'

feature 'Sign up', :js => true do
  before do
    @user = FactoryGirl.build(:user)
  end
  
  subject{page}
   scenario "and sees signup page" do
     visit signup_path 
     click_link "Sign Up!"
     expect(page).to have_css("h3",text:"Sign up for a free account")
  end
 
  context "and signs up" do
    scenario 'with valid email and password' do
 
  
       sign_up_with(@user.name,@user.email,"akk322")
     
       page.should have_content "Welcome #{@user.name}"    
       expect(page).to have_link('Sign out')   
     
     
      
       click_button "SendTimetable" 
      
      
      
     
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
  scenario 'with valid email and password, logs out' do
 
 
     sign_up_with(@user.name,@user.email,"akk322")
   
     page.should have_content "Welcome #{@user.name}"    
     expect(page).to have_link('Sign out')   
   
   
    
     click_link "Sign out"
    
     expect(page).to have_css "a",text:"Log In"
     
     
    
   
  end
  
  scenario 'with valid email and password, logs out and signs in again' do


     sign_up_with(@user.name,@user.email,"akk322")
   
     page.should have_content "Welcome #{@user.name}"    
     expect(page).to have_link('Sign out')   
   
   
    
     click_link "Sign out"
     
     
     click_link "Log In"
     
    
     sign_in_as(@user)
     
     
     
     expect(page).to have_content "a",text:"Welcome #{@user.name}"
     
     expect(page).to have_link "Sign out",href:signout_path
      
     expect(page).not_to have_link('Log In', href: signin_path) 
     
    
       
       group = @user.groups.build(name:'Electronics')

       fill_in "group",with:group.name
  
  
        within("#new_group") do
           click_button "creategroupbutton"
        end
        
        expect(page).to have_css("a",text: group.name)
        
        
        
        click_link "Send Alert"
        
        expect(page).to have_css("#createalertinput")
        
        fill_in "createalertinput",with: "Sending alert...."
        
         expect(page).to have_button("sendalert")
        
        click_button "sendalert"
  end
end
      






end


   