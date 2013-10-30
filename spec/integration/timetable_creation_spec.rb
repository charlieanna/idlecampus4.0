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
     
      teachers = FactoryGirl.build_list(:teacher,28)
     
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
     
      subjects = FactoryGirl.build_list(:subject,28)
     
      subjects.each do |subject|
        fill_in "newsubject",with: subject.name
     
        click_button "addsubject"
      end
     
      click_button "Rooms"
      rooms = FactoryGirl.build_list(:room,28)
     
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
      # check "addbatch1"
      
     add_entry(1,7)
      
      # click_link_def "sub1" 
 #      
     #  select "teacher1",from: "teacher1"
#       select "subject1",from: "subject1"
#       select "room1",from: "room1"
# #       # select "teacher1",from: "teacher1"
# #  #      select "subject1",from: "subject1"
# #  #      select "room1",from: "room1"
# #  #      select "teacher1",from: "teacher2"
# #  #      select "subject1",from: "subject2"
# #  #      select "room1",from: "room2"
#       click_button "close1"   
#       click_link_def "sub2"
#       select "teacher2",from: "teacher2"
#       select "subject2",from: "subject2"
#       select "room2",from: "room2"
#       click_button "close2" 
#       click_link_def "sub3"
#       select "teacher3",from: "teacher3"
#       select "subject3",from: "subject3"
#       select "room3",from: "room3"
#       click_button "close3" 
# # #       
# # #      
# #       # check "addbatch4" 
#       click_link_def "sub4"
#       
#       select "teacher1",from: "teacher4"
#       select "subject1",from: "subject4"
#       select "room1",from: "room4"
# #       # select "teacher1",from: "teacher1"
# #  #      select "subject1",from: "subject1"
# #  #      select "room1",from: "room1"
# #  #      select "teacher1",from: "teacher2"
# #  #      select "subject1",from: "subject2"
# #  #      select "room1",from: "room2"
#        click_button "close4" 
# # 
#       click_link_def "sub5"
#       select "teacher3",from: "teacher5"
#       select "subject2",from: "subject5"
#       select "room2",from: "room5"
#       click_button "close5"
#       click_link_def "sub6"
#       select "teacher6",from: "teacher6"
#       select "subject6",from: "subject6"
#       select "room6",from: "room6" 
#       click_button "close6"
# #      
# #       
# # #       
# # #       
#        click_link_def "sub7"
#        select "teacher7",from: "teacher7"
#        select "subject7",from: "subject7"
#      select "room7",from: "room7"
#        click_button "close7" 
       
       
  #     
      select "11 AM",from: "from_hour"
      select 30,from: "from_minute"
      select "2 PM",from: "to_hour"
      select 10,from: "to_minute"
      click_button "AddRow"
      
      add_entry(8,14)
    
# # #    
#       click_link_def "sub8" 
#       select "teacher1",from: "teacher"
#       select "subject1",from: "subject"
#       select "room1",from: "room"
#       click_button "close" 
#       
#       
#       click_link_def "sub9"
#       select "teacher2",from: "teacher"
#       select "subject2",from: "subject"
#       select "room2",from: "room"
#       click_button "close" 
#       click_link_def "sub10"
#       select "teacher3",from: "teacher"
#       select "subject3",from: "subject"
#       select "room3",from: "room"
#       click_button "close" 
#       click_link_def "sub11"
#       select "teacher3",from: "teacher"
#       select "subject2",from: "subject"
#       select "room2",from: "room"
#       click_button "close"
#       click_link_def "sub12"
#       select "teacher3",from: "teacher"
#       select "subject2",from: "subject"
#       select "room2",from: "room"
#       click_button "close"
#       click_link_def "sub13"
#       select "teacher3",from: "teacher"
#       select "subject2",from: "subject"
#       select "room2",from: "room" 
#       click_button "close"
#       click_link_def "sub14" 
#       select "teacher1",from: "teacher"
#       select "subject1",from: "subject"
#       select "room1",from: "room"
#       click_button "close" 
      select "3 PM",from: "from_hour"
      select 10,from: "from_minute"
      select "5 PM",from: "to_hour"
      select 20,from: "to_minute"
      click_button "AddRow"
      
      add_entry(15,21)
#       
#         
#       click_link_def "sub15"
#       select "teacher2",from: "teacher"
#       select "subject2",from: "subject"
#       select "room2",from: "room"
#       click_button "close" 
#       click_link_def "sub16"
#       select "teacher3",from: "teacher"
#       select "subject3",from: "subject"
#       select "room3",from: "room"
#       click_button "close" 
#       click_link_def "sub18"
#       select "teacher3",from: "teacher"
#       select "subject2",from: "subject"
#       select "room2",from: "room"
#       click_button "close"
#       click_link_def "sub19"
#       select "teacher3",from: "teacher"
#       select "subject2",from: "subject"
#       select "room2",from: "room"
#       click_button "close"
# #       
#       click_link_def "sub20"
#       select "teacher3",from: "teacher"
#       select "subject2",from: "subject"
#       select "room2",from: "room" 
#       click_button "close"
#       click_link_def "sub21"
#       select "teacher3",from: "teacher"
#       select "subject2",from: "subject"
#       select "room2",from: "room"
#       click_button "close" 
# #   #     
      select "5 PM",from: "from_hour"
      select 30,from: "from_minute"
      select "7 PM",from: "to_hour"
      select 10,from: "to_minute"
      click_button "AddRow"
      
      add_entry(22,28)
#       click_link_def "sub22" 
#       select "teacher1",from: "teacher"
#       select "subject1",from: "subject"
#       select "room1",from: "room"
#       click_button "close" 
#       click_link_def "sub23"
#       select "teacher2",from: "teacher"
#       select "subject2",from: "subject"
#       select "room2",from: "room"
#       click_button "close" 
#       click_link_def "sub24"
#       select "teacher3",from: "teacher"
#       select "subject3",from: "subject"
#       select "room3",from: "room"
#       click_button "close" 
#       click_link_def "sub25"
#       select "teacher3",from: "teacher"
#       select "subject2",from: "subject"
#       select "room2",from: "room"
#       click_button "close"
#       click_link_def "sub26"
#       select "teacher3",from: "teacher"
#       select "subject2",from: "subject"
#       select "room2",from: "room"
#       click_button "close"
#       click_link_def "sub27"
#       select "teacher3",from: "teacher"
#       select "subject2",from: "subject"
#       select "room2",from: "room" 
#       click_button "close"
#       click_link_def "sub28"
#       select "teacher3",from: "teacher"
#       select "subject2",from: "subject"
#       select "room2",from: "room" 
#       click_button "close"
#       
      
  #     
  #     
      
end

scenario 'with valid email and password' do
 
      click_button "SendTimetable" 
      
      click_link @group1.name
  end
 
end

def add_entry(from,to)
  from.upto(to) do |index| 
    puts  "sub#{index}"
    click_link_def "sub#{index}"
    select "teacher#{index}",from: "teacher#{index}"
    select "subject#{index}",from: "subject#{index}"
    select "room#{index}",from: "room#{index}"
    click_button "close#{index}"   
  end
end

def click_link_def(el)
 
  page.find("##{el}").trigger(:click) 
end
def open_page
  save_and_open_page
end


   