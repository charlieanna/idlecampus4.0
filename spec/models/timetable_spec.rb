require 'spec_helper'

describe Timetable do
  before do
  	@timetable = Timetable.new
  end
  subject {@timetable}

  it {should respond_to(:timetable_entries)}
end
