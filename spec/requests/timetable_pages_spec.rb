require "spec_helper"

describe "Creating a timetable with many entries" do
  describe "Creating a timetable entry using a factory" do
    before do
       @user = FactoryGirl.create(:user)
     
      timetable = FactoryGirl.create(:timetable)
      timetable_entry = FactoryGirl.create(:timetable_entry)
      weekday1 = FactoryGirl.create(:weekday)
      weedkay2 = FactoryGirl.create(:weekday)
      weekday3 = FactoryGirl.create(:weekday)
      weedkay4 = FactoryGirl.create(:weekday)
      weekday5 = FactoryGirl.create(:weekday)
      weedkay6 = FactoryGirl.create(:weekday)
      weekday7 = FactoryGirl.create(:weekday)
      subject1 = FactoryGirl.create(:subject)
      subject2 = FactoryGirl.create(:subject)
      subject3 = FactoryGirl.create(:subject)
      subject4 = FactoryGirl.create(:subject)
      subject5 = FactoryGirl.create(:subject)
      subject6 = FactoryGirl.create(:subject)
      teacher1 = FactoryGirl.create(:teacher)
      teacher2 = FactoryGirl.create(:teacher)
      teacher3 = FactoryGirl.create(:teacher)
      teacher4 = FactoryGirl.create(:teacher)
      teacher5 = FactoryGirl.create(:teacher)
      teacher6 = FactoryGirl.create(:teacher)
      [1..30].each do 
        
      end
     
      
      
    end
     let(:group) {FactoryGirl.create(:group)}
    it "user should respond to group" do
       # puts timetable
    end
  end
   
end
