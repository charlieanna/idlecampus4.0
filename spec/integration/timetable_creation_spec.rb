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
      
      # batches = FactoryGirl.build_list(:small_group,3)
     
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
     
      select "teacher1",from: "teacher1"
      select "subject1",from: "subject1"
      select "room1",from: "room1"
     
      select "teacher1",from: "teacher2"
      select "subject1",from: "subject2"
      select "room1",from: "room2"

      select "teacher1",from: "teacher3"
      select "subject1",from: "subject3"
      select "room1",from: "room3"
       click_button "close1" 
       check "addbatch2" 
       click_link_def "sub2"
      
      
       select "teacher1",from: "teacher1"
       select "subject1",from: "subject1"
       select "room1",from: "room1"
     
       select "teacher1",from: "teacher2"
       select "subject1",from: "subject2"
       select "room1",from: "room2"

       select "teacher1",from: "teacher3"
       select "subject1",from: "subject3"
       select "room1",from: "room3"
       click_button "close2"
        
       open_page  
       add_entry(3,7)

      select "11 AM",from: "from_hour"
      select 30,from: "from_minute"
      select "2 PM",from: "to_hour"
      select 10,from: "to_minute"
      click_button "AddRow"
      
       add_entry(8,14)
    

      select "3 PM",from: "from_hour"
      select 10,from: "from_minute"
      select "5 PM",from: "to_hour"
      select 20,from: "to_minute"
      click_button "AddRow"
      
       add_entry(15,21)
     
      select "5 PM",from: "from_hour"
      select 30,from: "from_minute"
      select "7 PM",from: "to_hour"
      select 10,from: "to_minute"
      click_button "AddRow"
      
        add_entry(22,28)

      
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

def add_with_batch_at(place)
  
end

def click_link_def(el)
 
  page.find("##{el}").trigger(:click) 
end
def open_page
  save_and_open_page
end


   