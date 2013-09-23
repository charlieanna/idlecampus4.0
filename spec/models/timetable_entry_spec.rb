require 'spec_helper'

describe TimetableEntry do
  let(:timetable) {FactoryGirl.create(:timetable)}

  before do
  	@timetable_entry = timetable.timetable_entries.build
  end

  subject{ @timetable_entry}

  it {should respond_to(:timetable_id)}
  it { should respond_to(:timetable) }
  it {should respond_to(:weekday)}
  its(:timetable) { should eq timetable }

  describe "when timetable_id is not present" do
    before { @timetable_entry.timetable_id = nil }
    it { should_not be_valid }
  end
end
