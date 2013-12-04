require_relative '../spec_helper'

describe Weekday do

	before { @weekday = Weekday.new(name: "Sunday") }

  subject { @weekday } 

  it { should respond_to(:name) }
 
	
end