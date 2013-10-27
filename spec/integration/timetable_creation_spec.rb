require 'spec_helper'

feature "A teacher" do 
	before do
		@user = Factory.build(:user)  # returns an unsaved object
		@group = FactoryGirl.create(:group,:user)
    teacher1 = FactoryGirl.build(:teacher)
		teacher2 = FactoryGirl.build(:teacher)
		teacher3 = FactoryGirl.build(:teacher)
		teacher4 = FactoryGirl.build(:teacher)
		teacher5 = FactoryGirl.build(:teacher)
    subject1 = FactoryGirl.build(:subject)
    subject2 = FactoryGirl.build(:subject)
    subject3 = FactoryGirl.build(:subject)
    subject4 = FactoryGirl.build(:subject)
    subject5 = FactoryGirl.build(:subject)
	end
  before do
  	sign_up_with(@user.name,@user.email,"akk322")
    logout
  	sign_in_as(@user)
  	create_group(@group)
  	click_group(@group)
  	click_button "Create Timetable"
  	fill_in "Teacher",with: "Ankur"
  	fill_in "Teacher",with: "Debasis"
  	fill_in "Teacher",with: "Swati"
  	fill_in "Teacher",with: "Ankita"
  	fill_in "Teacher",with: "Aditi"
  	check "Monday"
  	check "Tuesday"
  	check "Wendesday"
  	check "Thursday"
  	check "Friday"
  	check "Saturday"
  	check "Sunday"
  	check "Add Group"
  	fill_in "Batch",with: "C1"
  	click "Add Batch"
  	fill_in "Batch",with: "C2"
  	click "Add Batch"
  	fill_in "subject",with:"Maths"
  	fill_in "subject",with:"Phyics"
  	fill_in "subject",with:"Chemistry"
  	fill_in "subject",with:"Computer Science"
  	fill_in "subject",with:"Algorithms"
  	fill_in "room1",with:"room1"
  	fill_in "room2",with:"room2"
  	fill_in "room3",with:"room3"
    fill_in "room3",with:"room4"
  	fill_in "room3",with:"room5"
    select '9', :from => 'from_hour'
    select '10', :from => 'from_minutes'
    select '9', :from => 'to_hour'
    select '10', :from => 'to_minutes'
    click_button "Add Row"
   
    check "Add Batch?"
    select 'Ankur1',from:"Teachers"
    select "Ankur1",from:"Students"
    select "Room1",from:"Rooms"
    select 'Ankur2',from:"Teachers"
    select "Ankur2",from:"Students"
    select "Room2",from:"Rooms"
    click_button "Send Timetable"




  	
  end
	
end