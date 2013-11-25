require_relative '../spec_helper'

feature "A student" ,js: true do
  before do
    @user = FactoryGirl.build(:user)
    sign_up_with(@user.name,@user.email,"akk322")
    group = @user.groups.build(name:'Electronics')
    
    fill_in "group_name",with:group.name
    
  

     within("#new_group") do
        click_button "creategroupbutton1"
     end
     
     click_link "Sign out"
  end
  scenario "joins a group" do
    
   
    # visit '/'
    # group = FactoryGirl.create(:group,name:"Electronics",group_code:"6V9GG7")
     @user1 = FactoryGirl.build(:user)
    # click_link "Sign Up As Student!"
      visit '/'
      params = {"user"=>{"rolable_type"=>"Student", "name"=>@user1.name, "email"=>@user1.email, "password"=>"akk322"}, "commit"=>"Create Account", "action"=>"create", "controller"=>"users","Group Code"=>"6V9GG7"}
       user = User.new
    	xhr :post, users_path(user),params
      visit signin_path
        sign_in_as(@user1)
        
        # expect(page).to have_css("#group_code","JATZ6E")
 #   
 #    fill_in "Group_Code",with:group.group_code
 #    fill_in "Name",with:@user1.name
 #    fill_in "Email",with:@user1.email
 #    fill_in "Password",with:@user1.password
 #     click_button "Create Account"
    
  end
  
  
end