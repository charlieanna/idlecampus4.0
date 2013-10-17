require "spec_helper"

describe TimetableEntry do
	before{ @timetable = TimetableEntry.new}
	subject{@timetable}
	it{should respond_to(:timetable_entries)}
	it{should respond_to(:weekdays)}
	it{should respond_to(:group)}
	it {should respond_to(:create_timetable)}
	it {should respond_to(:create_field)}
	it {should respond_to(:create_record_for)}
	it {should respond_to(:get_entries)}
	it {should respond_to(:build_f)}

	
end