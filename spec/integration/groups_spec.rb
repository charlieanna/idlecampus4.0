require "spec_helper"
 include SessionsHelper
describe "Groups" do

  it "signed in user should be able to create a group" do
    user = FactoryGirl.create(:user)
	 
    
    sign_in user, no_capybara: true
    
    
    expect do
            xhr :post, user_groups_path(user), group: { name:"Electronics" }
          end.to change(user.groups, :count).by(1)
       
   end  

  it "signed in user should be able see the groups he has created" do
    user = FactoryGirl.create(:user)
   
    
    sign_in user, no_capybara: true
     puts user.name
    group1 = FactoryGirl.create(:group,user: user)
    group2 = FactoryGirl.create(:group,user: user)
    
    puts user.groups
    xhr :get, user_groups_path(user),format: :json

    print response.body
   response.should be_success
   # response.should render_template('email')
    # expect(page).to have_css "ul#sidebar li"
    # expect(page).to have_css "ul#groupscreated li",text:group2.name

  end
end

def sign_in(user, options={})
  if options[:no_capybara]
    # Sign in when not using Capybara.
    remember_token = User.new_remember_token
    cookies[:remember_token] = remember_token
    user.update_attribute(:remember_token, User.encrypt(remember_token))
  else
	  # visit '/'
 #     click_link "Log In"
 # 
 #     fill_in "session_email",with: user.email
 #     fill_in "session_password",with:user.password
 #     
 #     within("#login-content") do
 #     
 #     click_button "Login"
 #     
 #      
 #    end
  end
end