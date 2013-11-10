require 'spec_helper'

describe GroupsController do
  describe "#show" do
    it "when group is present" do
      group = FactoryGirl.create(:group)
      resp = get :show, id: group.group_code
      expect(resp.body).to eq(group.to_json)
    end
    
    it "when group is not present" do
      
      resp = get :show, id: "not present"
      expect(resp.body).to eq("group not found")
    end
  end
end