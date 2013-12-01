require_relative '../spec_helper'

describe Push do
  before(:all) do
 
             
   
    @user1 = FactoryGirl.create(:user, :device_identifier => "a9c72e102f1bc1b0")
	  @user2 = FactoryGirl.create(:user, :device_identifier => "7d94095209b6e051")
	  @user3 = FactoryGirl.create(:user, :device_identifier => "85718da6d39b75c5")
	  @user4 = FactoryGirl.create(:user, :device_identifier => "4BA905D6-443D-4631-A7BD-DEDEA1638BA1")
	  @user5 = FactoryGirl.create(:user, :device_identifier => "9dce6d95d8b1ae67")
	  @users = [@user1.jabber_id, @user2.jabber_id, @user3.jabber_id, @user4.jabber_id, @user5.jabber_id]
	  @push = Push.new(@users, "Hi","timetable")
  end

  after(:all) do
    @user1.destroy
	  @user2.destroy
	  @user3.destroy
	  @user4.destroy
	  @user5.destroy
	 
  end
  
  subject { @push }

  it { should respond_to(:create_push) }
  it { should respond_to(:send_push) }
  it { should respond_to(:devices) }
  
  describe "#devices" do
    it "returns the device_identifiers of all the members" do
     
      expect(@push.devices).to include(@user1.device_identifier, @user2.device_identifier, @user3.device_identifier, @user4.device_identifier, @user5.device_identifier)
    
    end
  end

  describe "#create_push" do
    it "returns the push hash" do

      push_hash = @push.create_push
      expect(push_hash).to eq({"push" => {"devices" => @push.devices, "message" => @push.message, "app"=>"timetable"}})

    end
  end


  it "#send_push" do


    resp = @push.send_push


    expect(resp).to eq "200"
  end



end