require_relative '../spec_helper'

describe "Authentication", :js => true do

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
       
         sign_up_with(user.name,user.email,"akk322")
  #  
  #      
  #   
         click_link "Sign out"
  #    
  #    
         click_link "Log In"
     
    
        sign_in_as(user)
      end
      # end
     it { should have_content "Welcome #{user.name}" }
      # it { should have_title(user.name) }
      # it { should have_link('Profile',     href: user_path(user)) }
       it { should have_link('Sign out',    href: signout_path) }
       it { should_not have_link('Log In', href: signin_path) }
       
       it "and then creates a group" do
         
         group = user.groups.build(name:'Electronics')
  
         fill_in "group",with:group.name
    
    
          within("#new_group") do
             click_button "creategroupbutton"
          end
          
          expect(page).to have_css("a",text: group.name)
       end
    end
  end
  
   
 


  
end
