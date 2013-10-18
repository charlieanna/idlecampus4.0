require_relative '../spec_helper'

describe "Timetable Page" do
   before(:all) do
    @user1 = FactoryGirl.create(:user, :device_identifier => "a9c72e102f1bc1b0")
    @user2 = FactoryGirl.create(:user, :device_identifier => "7d94095209b6e051")
    @user3 = FactoryGirl.create(:user, :device_identifier => "85718da6d39b75c5")
    @user4 = FactoryGirl.create(:user, :device_identifier => "4BA905D6-443D-4631-A7BD-DEDEA1638BA1")
    @user5 = FactoryGirl.create(:user, :device_identifier => "9dce6d95d8b1ae67")
    @users = [@user1.jabber_id, @user2.jabber_id, @user3.jabber_id, @user4.jabber_id, @user5.jabber_id]
    @push = Push.new(@users, "Hi")
  end

  after(:all) do
    @user1.destroy
    @user2.destroy
    @user3.destroy
    @user4.destroy
    @user5.destroy
   
  end
	subject { page }

  let(:user) { FactoryGirl.create(:user) }

  before {
  	 visit '/'
	  click_link "Log In"

	  fill_in "session_email",with: user.email
	  fill_in "session_password",with:user.password
	  
	  within("#login-content") do
	  
     click_button "Login"
     
	   
    end
  }

  describe "timetable creation" do
  	

  	describe "with valid information" do
      it " should create the timetable" do
        group = Group.create(name:"Electronics",group_code:"9A2KVG")
        
        params = {"timetable"=>{"members"=>@users,"entries"=>"[[[{\"from_hours\":\"09\",\"from_minutes\":\"00\",\"to_minutes\":\"00\",\"to_hours\":\"10\",\"weekday\":\"Monday\",\"$$hashKey\":\"00M\",\"teacher\":\"Ankur\",\"subject\":\"Maths\",\"location\":\"room1\"}]],[[{\"from_hours\":\"10\",\"from_minutes\":\"00\",\"to_minutes\":\"00\",\"to_hours\":\"11\",\"weekday\":\"Monday\",\"$$hashKey\":\"00U\"}]]]", "group"=>{"name"=>"dsadasdas", "group_code"=>"9A2KVG", "$$hashKey"=>"009"}}, "group_id"=>"9A2KVG"}

      	xhr :post, group_timetables_path(group),params
        expect(response.code).to eq("200")
     end
    end
  end

  describe "getting the timetable" do

    it "shoud get me the timetable for the group" do
     group = Group.create(name:"Electronics",group_code:"9A2KVG")

     # puts group.id
        
     params = {"timetable"=>{"members"=>@users,"entries"=>"[[[{\"from_hours\":\"09\",\"from_minutes\":\"00\",\"to_minutes\":\"00\",\"to_hours\":\"10\",\"weekday\":\"Monday\",\"$$hashKey\":\"00M\",\"teacher\":\"Ankur\",\"subject\":\"Maths\",\"location\":\"room1\"}]],[[{\"from_hours\":\"10\",\"from_minutes\":\"00\",\"to_minutes\":\"00\",\"to_hours\":\"11\",\"weekday\":\"Monday\",\"$$hashKey\":\"00U\"}]]]", "group"=>{"name"=>"dsadasdas", "group_code"=>"9A2KVG", "$$hashKey"=>"009"}}, "group_id"=>"9A2KVG"}

     xhr :post, group_timetables_path(group),params

     xhr :get,group_timetables_path(group),group_code: "9A2KVG"
     
     expect(response.code).to eq("200")

   end

  end
end