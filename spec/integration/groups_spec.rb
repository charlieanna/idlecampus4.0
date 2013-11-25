require_relative '../spec_helper'
require 'database_cleaner'
describe "Teacher creates a group" , :js => true do
  
  before do
    @user = FactoryGirl.build(:user)
    sign_up_with(@user.name,@user.email,"akk322")
  end

  it "with a valid name" do
   
    
   
    group1 = @user.groups.build(name:'Electronics')
    group2 = @user.groups.build(name:'Mechanical')
    
    fill_in "group",with:group1.name
    
    
     within("#new_group") do
        click_button "creategroupbutton"
     end
 #     
     fill_in "group",with:group2.name 
    
    
      within("#new_group") do
         click_button "creategroupbutton"
      end  
     
     expect(page).to have_css("a",text: group1.name)
     expect(page).to have_css("a",text: group2.name)
     expect(page).not_to have_css("#timetable")
     click_link group1.name
     
  
      
    click_button "SendTimetable"
    
    
    
   end 
   
end

def open_page
  save_and_open_page
end

