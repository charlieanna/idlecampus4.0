require_relative '../spec_helper'

describe TimetableEntry do
	
	 before do 
	 	@timetable_entry = FactoryGirl.create(:timetable_entry)
   
 end
	subject{@timetable_entry}
	it{should respond_to(:timetable)}
	it{should respond_to(:weekday)}
	it{should respond_to(:teacher)}
	it{should respond_to(:subject)}
	it{should respond_to(:room)}
	it{should respond_to(:class_timing)}
  it{should respond_to(:small_group)}

  it{should respond_to(:to_hash)}



  # describe "#to_hash" do
 #    it "should return a hash" do
 #     result = @timetable_entry.to_hash
 #     expect(result).to eq({"weekday"=>"weekday9", "teacher"=>"teacher9", "subject"=>"subject9", "room"=>"room9", "batch"=>"batch9", "to_hours"=>"9", "to_minutes"=>"9", "from_minutes"=>"9", "from_hours"=>"9"})
 #    end
 #  end
 
 describe "get" do
   it "lets see" do
     entry = {"from_hours"=>"09", "from_minutes"=>"10", "to_minutes"=>"20", "to_hours"=>"11", "weekday"=>"Monday", "$$hashKey"=>"01Q", "teacher"=>"teacher1", "subject"=>"subject1", "room"=>"room1"}
     timetable = Timetable.create
     t = TimetableEntry.get(entry,timetable)
     expect(t.id).to eq(2)
   end
 end






	
end