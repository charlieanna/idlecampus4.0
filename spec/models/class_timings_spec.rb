require "spec_helper"

describe ClassTiming do
	before { @class_timing = ClassTiming.new(:to_hours => "1", :to_minutes => "30", :from_hours => "2", :from_minutes => 59)}
  
  subject { @class_timing }

  it { should respond_to(:to_hours) }
  it { should respond_to(:to_minutes) }
  it { should respond_to(:from_hours) }
  it { should respond_to(:from_minutes) }
 
end