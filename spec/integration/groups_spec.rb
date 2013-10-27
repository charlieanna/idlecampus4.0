require_relative '../spec_helper'
describe "Teacher creates a group" do
  
  let(:user) { FactoryGirl.create(:user)}
  before do
    sign_in_as user, no_capybara: true
  end
  it "with a valid name" do
    group = FactoryGirl.build(:group,user: user)
    fill_in "Group Name",with:group.name
     within("#new_group") do
        click_button "Create"
     end
    
    
    expect do
      xhr :post, user_groups_path(user), group: { name:"Electronics" }
    end.to change(user.groups, :count).by(1)
  end  

  it "and then sees the group in the list of groups" do

    group1 = FactoryGirl.create(:group,user: user)
    group2 = FactoryGirl.create(:group,user: user)
    
    
    xhr :get, user_groups_path(user),format: :json
    response.body.should_not eq([])
    response.should be_success
  
  end

  it "can click on the group that was created" do
    group1 = FactoryGirl.create(:group,user: user)
    expect(page).to have_css "#groups #{group1}",text:group1.text
  end
end

