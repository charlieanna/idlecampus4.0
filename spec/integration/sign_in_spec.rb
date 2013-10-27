require_relative '../spec_helper'

describe "Authentication" do

subject { page }

  describe "signin page" do
      before { visit signin_path }
   
    it { should have_content('Login to your user account') }
    it { should have_title('Sign in') }
  end


  describe "signin" do
    before { visit signin_path }

    describe "with invalid information" do
      before do 
        within("#login-content") do
	      click_button "Login"
      end
    end

      it { should have_title('Sign in') }
      it { should have_selector('div.alert.alert-error', text: 'Invalid') }
       describe "after visiting another page" do
        before { visit '/' }
        it { should_not have_selector('div.alert.alert-error') }
      end
    end


     describe "with valid information" do
      let(:user) { FactoryGirl.create(:user) }
      before do
        sign_in_as(user)
      end
     it { should have_content "Welcome #{user.name}" }
      # it { should have_title(user.name) }
      # it { should have_link('Profile',     href: user_path(user)) }
       it { should have_link('Sign out',    href: signout_path) }
       it { should_not have_link('Log In', href: signin_path) }
    end
  end
  
   
 


  
end
