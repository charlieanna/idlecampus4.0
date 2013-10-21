require_relative '../spec_helper'

describe TimetableEntry do
	before{ @timetable = TimetableEntry.new}
	subject{@timetable}
	it{should respond_to(:timetable_entries)}
	it{should respond_to(:weekdays)}
	it{should respond_to(:group)}


	
end