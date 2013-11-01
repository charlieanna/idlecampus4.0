require_relative '../spec_helper'
require 'multi_json'
describe Timetable do
	before{ @timetable = Timetable.new}
	subject{@timetable}
	it{should respond_to(:timetable_entries)}
	it{should respond_to(:weekdays)}
	it{should respond_to(:group)}
	it {should respond_to(:create_timetable)}


	describe "#create_timetable" do

		it "should create the timetable_entries for the given entries" do
			# puts MultiJson.load('{"abc":"def"}')
   #    params = MultiJson.load('{"entries":"[[[{"from_hours":"09","from_minutes":"00","to_minutes":"00","to_hours":"10","weekday":"Monday","$$hashKey":"00M","asdasdas":"asdasda"}]],[[{"from_hours":"10","from_minutes":"00","to_minutes":"00","to_hours":"11","weekday":"Monday","$$hashKey":"00U"}]]]"}')
   #    puts params
   #    @timetable.create_timetable params


		end
	end
	


end