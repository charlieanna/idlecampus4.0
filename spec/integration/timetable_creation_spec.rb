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
  	add_teacher "Ankur"
    add_teacher "Debasis"
  	add_teacher "Swati"
  	add_teacher "Ankita"
  	add_teacher "Aditi"

  	check_weekday "Monday"
  	check_weekday "Tuesday"
  	check_weekday "Wendesday"
  	check_weekday "Thursday"
  	check_weekday "Friday"
  	check_weekday "Saturday"
  	check_weekday "Sunday"
  	add_batch "C1"
  	add_batch "C2"

  	add_subject "Maths"
  	add_subject "Phyics"
  	add_subject "Chemistry"
  	add_subject "Computer Science"
  	add_subject "Algorithms"

  	add_room "room1"
  	add_room "room2"
  	add_room "room3"
    add_room "room4"
  	add_room "room5"
    add_to_time("9","0")
    add_from_time("10","30")
    click_button "Add Row"

    check "Add Batch?"

    select 'Ankur1',from:"Teachers"
    select "Ankur1",from:"Students"
    select "Room1",from:"Rooms"
    select 'Ankur2',from:"Teachers"
    select "Ankur2",from:"Students"
    select "Room2",from:"Rooms"
   
  end
   click_button "Send Timetable"
   expect(page).to have_content("Timetable Created.")
end