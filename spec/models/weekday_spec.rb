require 'spec_helper'

describe Weekday do
  it "should be valid with a proper weekday" do
  weekday= Weekday.new(:name=>"Monday")
 
  weekday.should be_valid
  weekday.should respond_to(:timetable_entries)

end

  it "should not be valid without valid weekdays" do
  	w = Weekday.new(name:"CakeDay")
  	w.should_not  be_valid
  end




end
