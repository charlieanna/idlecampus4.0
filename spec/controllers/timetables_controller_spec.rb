require 'spec_helper' 

describe TimetablesController do
  describe "#show" do
    
    it "returns the timetable json" do
      timetable = FactoryGirl.create(:timetable)
     get :show,use_route: :group_timetable
    end
  end 
end