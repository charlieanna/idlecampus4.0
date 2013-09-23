require "spec_helper"

feature "viewing a group" do
  scenario "Listing all groups" do
  	group = FactoryGirl.create(:group,name:"Electronics")
  	visit groups_path
  	click_link 'Electronics'
    expect(page.current_url).to eql(group_url(group))
  end
end