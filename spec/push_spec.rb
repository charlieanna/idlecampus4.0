require 'spec_helper'

describe Push do
	before do 
    @user1 = FactoryGirl.create(:user, :device_identifier => "a9c72e102f1bc1b0")
		@push = Push.new( [@user1.jabber_id],"Hi","message")
	end
	subject { @push }

   it { should respond_to(:message) }

  it { should respond_to(:members) }
  it { should respond_to(:app) }
  
  describe "#send_push" do
    it "returns with status code 200 when devices are present" do
      stub_request(:post, "http://developer.idlecampus.com/push/push1").
               with(:body => "{\"push\":{\"devices\":[\"a9c72e102f1bc1b0\"],\"message\":\"Hi\",\"app\":\"message\"}}",
                    :headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'Content-Type'=>'application/json', 'User-Agent'=>'Ruby'}).
               to_return(:status => 200, :body => "", :headers => {})
      resp = @push.send_push
      
      expect(resp).to eq("200")
    end
    
    it "returns with status code 404 when devices are not present" do
      @push = Push.new( [""],"Hi","message")
      stub_request(:post, "http://developer.idlecampus.com/push/push1").
               with(:body => "{\"push\":{\"devices\":[],\"message\":\"Hi\",\"app\":\"message\"}}",
                    :headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'Content-Type'=>'application/json', 'User-Agent'=>'Ruby'}).
               to_return(:status => 200, :body => "", :headers => {})
      resp = @push.send_push
      
      expect(resp).to eq("404")
    end
    
    
  end
end