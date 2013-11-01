require 'spec_helper'

describe TimetableParser do

	context '#parse' do
		it "correctly parses the params" do	
      Group.create(name:"Electronics",group_code:"9A2KVG")
      params = {"timetable"=>{"members"=>@users,"entries"=>"[[[{\"from_hours\":\"09\",\"from_minutes\":\"00\",\"to_minutes\":\"00\",\"to_hours\":\"10\",\"weekday\":\"Monday\",\"$$hashKey\":\"00M\",\"teacher\":\"Ankur\",\"subject\":\"Maths\",\"room\":\"room1\"}]],[[{\"from_hours\":\"10\",\"from_minutes\":\"00\",\"to_minutes\":\"00\",\"to_hours\":\"11\",\"weekday\":\"Monday\",\"$$hashKey\":\"00U\",\"teacher\":\"Ankur\",\"subject\":\"Maths\",\"room\":\"room1\"}]]]", "group"=>{"name"=>"dsadasdas", "group_code"=>"9A2KVG", "$$hashKey"=>"009"}}, "group_id"=>"9A2KVG"}

			timetable_parser = TimetableParser.new(params)

			result = timetable_parser.parse
			
			expect(result).to eq({"group_code"=>"9A2KVG", "entries"=>[[[{"from_hours"=>"09", "from_minutes"=>"00", "to_minutes"=>"00", "to_hours"=>"10", "weekday"=>"Monday", "$$hashKey"=>"00M", "teacher"=>"Ankur", "subject"=>"Maths", "room"=>"room1"}]], [[{"from_hours"=>"10", "from_minutes"=>"00", "to_minutes"=>"00", "to_hours"=>"11", "weekday"=>"Monday", "$$hashKey"=>"00U", "teacher"=>"Ankur", "subject"=>"Maths", "room"=>"room1"}]]], "members"=>nil})
		end
  end
end