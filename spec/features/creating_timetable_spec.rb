require 'spec_helper'

feature "Creating a timetable within a group" do
  before do
  	FactoryGirl.create(:group,name:"Electronics")
  	visit groups_path
  	click_link "Electronics"
  	click_link "New Timetable"
  end

  scenario "creating a new timetable for a group" do
  	click_button "Create Timetable"
    expect(page).to have_content("Timetable has been created.")
  end

end