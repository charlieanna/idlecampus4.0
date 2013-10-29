require_relative '../spec_helper'

feature 'Visitor signs up', :js => true do
  before do
    @user = FactoryGirl.build(:user)
  
 
  
     sign_up_with(@user.name,@user.email,"akk322")
     
    
     
     @group1 = @user.groups.build(name:'Electronics')
     # group2 = @user.groups.build(name:'Mechanical')
     
     fill_in "group",with:@group1.name
    
    
      within("#new_group") do
         click_button "creategroupbutton"
      end

    
      click_link @group1.name
         #     
      # expect(page).to have_css("#timetable")
#      
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
      
      click_button "Groups"
     
      check "addbatches"
     
      fill_in "newbatch",with:"C1"
      click_button "addbatch"
     
      fill_in "newbatch",with:"C2"
      click_button "addbatch"
     
      fill_in "newbatch",with:"C3"
      click_button "addbatch"
     
      
      
  #    
      click_button "close"
      select "09 AM",from: "from_hour"
      select 10,from: "from_minute"
      select "11 AM",from: "to_hour"
      select 20,from: "to_minute"
      click_button "AddRow"
      check "addbatch1"
      
      click_link_def "sub1" 
 #      
      select "teacher1",from: "teacher0"
      select "subject1",from: "subject0"
      select "room1",from: "room0"
      select "teacher1",from: "teacher1"
      select "subject1",from: "subject1"
      select "room1",from: "room1"
      select "teacher1",from: "teacher2"
      select "subject1",from: "subject2"
      select "room1",from: "room2"
      click_button "close"   
      click_link_def "sub2"
      select "teacher2",from: "teacher"
      select "subject2",from: "subject"
      select "room2",from: "room"
      click_button "close" 
      click_link_def "sub3"
      select "teacher3",from: "teacher"
      select "subject3",from: "subject"
      select "room3",from: "room"
      click_button "close" 
#       
#      
check "addbatch4" 
      click_link_def "sub4"
      
      select "teacher1",from: "teacher0"
      select "subject1",from: "subject0"
      select "room1",from: "room0"
      select "teacher1",from: "teacher1"
      select "subject1",from: "subject1"
      select "room1",from: "room1"
      select "teacher1",from: "teacher2"
      select "subject1",from: "subject2"
      select "room1",from: "room2"
      click_button "close" 

      click_link_def "sub5"
      select "teacher3",from: "teacher"
      select "subject2",from: "subject"
      select "room2",from: "room"
      click_button "close"
      click_link_def "sub6"
      select "teacher3",from: "teacher"
      select "subject2",from: "subject"
      select "room2",from: "room" 
      click_button "close"
#       
#       
       click_link_def "sub7"
       select "teacher3",from: "teacher"
       select "subject1",from: "subject"
     select "room2",from: "room"
       click_button "close" 
#   #     
      select "11 AM",from: "from_hour"
      select 30,from: "from_minute"
      select "2 PM",from: "to_hour"
      select 10,from: "to_minute"
      click_button "AddRow"
#    
      click_link_def "sub8" 
      select "teacher1",from: "teacher"
      select "subject1",from: "subject"
      select "room1",from: "room"
      click_button "close" 
      click_link_def "sub9"
      select "teacher2",from: "teacher"
      select "subject2",from: "subject"
      select "room2",from: "room"
      click_button "close" 
      click_link_def "sub10"
      select "teacher3",from: "teacher"
      select "subject3",from: "subject"
      select "room3",from: "room"
      click_button "close" 
      click_link_def "sub11"
      select "teacher3",from: "teacher"
      select "subject2",from: "subject"
      select "room2",from: "room"
      click_button "close"
      click_link_def "sub12"
      select "teacher3",from: "teacher"
      select "subject2",from: "subject"
      select "room2",from: "room"
      click_button "close"
      click_link_def "sub13"
      select "teacher3",from: "teacher"
      select "subject2",from: "subject"
      select "room2",from: "room" 
      click_button "close"
      click_link_def "sub14" 
      select "teacher1",from: "teacher"
      select "subject1",from: "subject"
      select "room1",from: "room"
      click_button "close" 
      select "3 PM",from: "from_hour"
      select 10,from: "from_minute"
      select "5 PM",from: "to_hour"
      select 20,from: "to_minute"
      click_button "AddRow"
      
        
      click_link_def "sub15"
      select "teacher2",from: "teacher"
      select "subject2",from: "subject"
      select "room2",from: "room"
      click_button "close" 
      click_link_def "sub16"
      select "teacher3",from: "teacher"
      select "subject3",from: "subject"
      select "room3",from: "room"
      click_button "close" 
      click_link_def "sub18"
      select "teacher3",from: "teacher"
      select "subject2",from: "subject"
      select "room2",from: "room"
      click_button "close"
      click_link_def "sub19"
      select "teacher3",from: "teacher"
      select "subject2",from: "subject"
      select "room2",from: "room"
      click_button "close"
#       
      click_link_def "sub20"
      select "teacher3",from: "teacher"
      select "subject2",from: "subject"
      select "room2",from: "room" 
      click_button "close"
      click_link_def "sub21"
      select "teacher3",from: "teacher"
      select "subject2",from: "subject"
      select "room2",from: "room"
      click_button "close" 
#   #     
      select "5 PM",from: "from_hour"
      select 30,from: "from_minute"
      select "7 PM",from: "to_hour"
      select 10,from: "to_minute"
      click_button "AddRow"
      click_link_def "sub22" 
      select "teacher1",from: "teacher"
      select "subject1",from: "subject"
      select "room1",from: "room"
      click_button "close" 
      click_link_def "sub23"
      select "teacher2",from: "teacher"
      select "subject2",from: "subject"
      select "room2",from: "room"
      click_button "close" 
      click_link_def "sub24"
      select "teacher3",from: "teacher"
      select "subject3",from: "subject"
      select "room3",from: "room"
      click_button "close" 
      click_link_def "sub25"
      select "teacher3",from: "teacher"
      select "subject2",from: "subject"
      select "room2",from: "room"
      click_button "close"
      click_link_def "sub26"
      select "teacher3",from: "teacher"
      select "subject2",from: "subject"
      select "room2",from: "room"
      click_button "close"
      click_link_def "sub27"
      select "teacher3",from: "teacher"
      select "subject2",from: "subject"
      select "room2",from: "room" 
      click_button "close"
      click_link_def "sub28"
      select "teacher3",from: "teacher"
      select "subject2",from: "subject"
      select "room2",from: "room" 
      click_button "close"
      
      
  #     
  #     
      
end

scenario 'with valid email and password' do
 
      click_button "SendTimetable" 
      open_page
 
  end
end

def click_link_def(el)
  puts "##{el}"
  page.find("##{el}").trigger(:click) 
end
def open_page
  save_and_open_page
end


   