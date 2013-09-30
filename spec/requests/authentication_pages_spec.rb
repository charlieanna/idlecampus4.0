require 'spec_helper'

describe "AuthenticationPages" do

  describe "Signup", type: :feature do
    it "signs me up" do
    
   visit '/'
   click_link "Sign up"
   fill_in "Name",with:"t"
   fill_in "Email",with:"t@t.com"
   fill_in "password",with:"t"
   click_button "Create my account"
  
   expect(page).to have_content("Welcome")
  end
end
 
end
