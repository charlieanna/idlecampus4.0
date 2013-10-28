require_relative '../spec_helper'
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
     
     expect(page).to have_css("#timetable")
     
     click_button "Create Timetable"
     
     click_button "Teachers"
     
     teachers = FactoryGirl.build_list(:teacher,3)
     
     teachers.each do |teacher|
       fill_in "newteacher",with: teacher.name
       click_button "addteacher"
     end
     
    
     
     click_button "Weekdays"
     
     
     
     check "monday"
     check "tuesday"
     check "wednesday"
     check "thursday"
     check "friday"
     check "saturday"
     check "sunday"
     
     click_button "Groups"
     
     check "addbatches"
     
     fill_in "newbatch",with:"C1"
     click_button "addbatch"
     
     fill_in "newbatch",with:"C2"
     click_button "addbatch"
     
     fill_in "newbatch",with:"C3"
     click_button "addbatch"
     
     click_button "Subjects"
     
     subjects = FactoryGirl.build_list(:subject,5)
     
     subjects.each do |subject|
       fill_in "newsubject",with: subject.name
     
       click_button "addsubject"
     end
     
     click_button "Rooms"
     rooms = FactoryGirl.build_list(:room,5)
     
     rooms.each do |room|
       fill_in "newroom",with: room.name
       
       click_button "addroom"
     end
     
     click_button "close"
     
      select "09 AM",from: "from_hour"
      select 10,from: "from_minute"
      select "11 AM",from: "to_hour"
      select 20,from: "to_minute"
      click_button "AddRow"
      click_link "sub1" 
      select "teacher1",from: "teacher"
      select "subject1",from: "subject"
      select "room1",from: "room"
      click_button "close"   
      click_link "sub2"
      select "teacher2",from: "teacher"
      select "subject2",from: "subject"
      select "room2",from: "room"
      click_button "close" 
      click_link "sub3"
      select "teacher3",from: "teacher"
      select "subject3",from: "subject"
      select "room3",from: "room"
      click_button "close" 
      click_link "sub4"
      select "teacher3",from: "teacher"
      select "subject2",from: "subject"
      select "room2",from: "room"
      click_button "close"
      click_link "sub5"
      select "teacher3",from: "teacher"
      select "subject2",from: "subject"
      select "room2",from: "room"
      click_button "close"
      click_link "sub6"
      select "teacher3",from: "teacher"
      select "subject2",from: "subject"
      select "room2",from: "room" 
      click_button "close"
      click_link "sub7"
      select "teacher3",from: "teacher"
      select "subject2",from: "subject"
      select "room2",from: "room"
      click_button "close" 
  #     
      select "11 AM",from: "from_hour"
      select 30,from: "from_minute"
      select "2 PM",from: "to_hour"
      select 10,from: "to_minute"
      click_button "AddRow"

      click_link "sub8" 
      select "teacher1",from: "teacher"
      select "subject1",from: "subject"
      select "room1",from: "room"
      click_button "close" 
      click_link "sub9"
      select "teacher2",from: "teacher"
      select "subject2",from: "subject"
      select "room2",from: "room"
      click_button "close" 
      click_link "sub10"
      select "teacher3",from: "teacher"
      select "subject3",from: "subject"
      select "room3",from: "room"
      click_button "close" 
      click_link "sub11"
      select "teacher3",from: "teacher"
      select "subject2",from: "subject"
      select "room2",from: "room"
      click_button "close"
      click_link "sub12"
      select "teacher3",from: "teacher"
      select "subject2",from: "subject"
      select "room2",from: "room"
      click_button "close"
      click_link "sub13"
      select "teacher3",from: "teacher"
      select "subject2",from: "subject"
      select "room2",from: "room" 
      click_button "close"
  #     click_link "sub14"
  #     select "teacher3",from: "teacher"
  #     select "subject2",from: "subject"
  #     select "room2",from: "room"
  #     click_button "close" 
      
       # click_button "SendTimetable"
    
   end 
   
end

def open_page
  save_and_open_page
end

