require_relative '../spec_helper'

describe "Timetable Page",js: true do
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

  before do
  	 visit '/'
	  click_link "Log In"

	  fill_in "session_email",with: user.email
	  fill_in "session_password",with:user.password
	  
	  within("#login-content") do
	  
     click_button "Login"
     
	   
    end
  end

  describe "timetable creation" do
  	

  	describe "with valid information" do
      it " should create the timetable" do
        group = Group.create(name:"Electronics",group_code:"9A2KVG")
        
        params = {"timetable"=>{"members"=>@users,"entries"=>"[[[{\"from_hours\":\"09\",\"from_minutes\":\"10\",\"to_minutes\":\"20\",\"to_hours\":\"11\",\"weekday\":\"Monday\",\"$$hashKey\":\"03N\",\"teacher\":\"teacher1\",\"subject\":\"subject1\",\"room\":\"room1\"}],[{\"from_hours\":\"09\",\"from_minutes\":\"10\",\"to_minutes\":\"20\",\"to_hours\":\"11\",\"weekday\":\"Tuesday\",\"$$hashKey\":\"047\",\"teacher\":\"teacher2\",\"subject\":\"subject2\",\"room\":\"room2\"}],[{\"from_hours\":\"09\",\"from_minutes\":\"10\",\"to_minutes\":\"20\",\"to_hours\":\"11\",\"weekday\":\"Wednesday\",\"$$hashKey\":\"04R\",\"teacher\":\"teacher3\",\"subject\":\"subject3\",\"room\":\"room3\"}],[{\"from_hours\":\"09\",\"from_minutes\":\"10\",\"to_minutes\":\"20\",\"to_hours\":\"11\",\"weekday\":\"Thursday\",\"$$hashKey\":\"05B\",\"teacher\":\"teacher4\",\"subject\":\"subject4\",\"room\":\"room4\"}],[{\"from_hours\":\"09\",\"from_minutes\":\"10\",\"to_minutes\":\"20\",\"to_hours\":\"11\",\"weekday\":\"Friday\",\"$$hashKey\":\"05V\",\"teacher\":\"teacher5\",\"subject\":\"subject5\",\"room\":\"room5\"}],[{\"from_hours\":\"09\",\"from_minutes\":\"10\",\"to_minutes\":\"20\",\"to_hours\":\"11\",\"weekday\":\"Saturday\",\"$$hashKey\":\"06F\",\"teacher\":\"teacher6\",\"subject\":\"subject6\",\"room\":\"room6\"}],[{\"from_hours\":\"09\",\"from_minutes\":\"10\",\"to_minutes\":\"20\",\"to_hours\":\"11\",\"weekday\":\"Sunday\",\"$$hashKey\":\"06Z\",\"teacher\":\"teacher7\",\"subject\":\"subject7\",\"room\":\"room7\"}]],[[{\"from_hours\":\"11\",\"from_minutes\":\"30\",\"to_minutes\":\"10\",\"to_hours\":\"14\",\"weekday\":\"Monday\",\"$$hashKey\":\"07Z\",\"teacher\":\"teacher8\",\"subject\":\"subject8\",\"room\":\"room8\"}],[{\"from_hours\":\"11\",\"from_minutes\":\"30\",\"to_minutes\":\"10\",\"to_hours\":\"14\",\"weekday\":\"Tuesday\",\"$$hashKey\":\"08J\",\"teacher\":\"teacher9\",\"subject\":\"subject9\",\"room\":\"room9\"}],[{\"from_hours\":\"11\",\"from_minutes\":\"30\",\"to_minutes\":\"10\",\"to_hours\":\"14\",\"weekday\":\"Wednesday\",\"$$hashKey\":\"093\",\"teacher\":\"teacher10\",\"subject\":\"subject10\",\"room\":\"room10\"}],[{\"from_hours\":\"11\",\"from_minutes\":\"30\",\"to_minutes\":\"10\",\"to_hours\":\"14\",\"weekday\":\"Thursday\",\"$$hashKey\":\"09N\",\"teacher\":\"teacher11\",\"subject\":\"subject11\",\"room\":\"room11\"}],[{\"from_hours\":\"11\",\"from_minutes\":\"30\",\"to_minutes\":\"10\",\"to_hours\":\"14\",\"weekday\":\"Friday\",\"$$hashKey\":\"0A7\",\"teacher\":\"teacher12\",\"subject\":\"subject12\",\"room\":\"room12\"}],[{\"from_hours\":\"11\",\"from_minutes\":\"30\",\"to_minutes\":\"10\",\"to_hours\":\"14\",\"weekday\":\"Saturday\",\"$$hashKey\":\"0AR\",\"teacher\":\"teacher13\",\"subject\":\"subject13\",\"room\":\"room13\"}],[{\"from_hours\":\"11\",\"from_minutes\":\"30\",\"to_minutes\":\"10\",\"to_hours\":\"14\",\"weekday\":\"Sunday\",\"$$hashKey\":\"0BB\",\"teacher\":\"teacher14\",\"subject\":\"subject14\",\"room\":\"room14\"}]],[[{\"from_hours\":\"15\",\"from_minutes\":\"10\",\"to_minutes\":\"20\",\"to_hours\":\"17\",\"weekday\":\"Monday\",\"$$hashKey\":\"0CB\",\"teacher\":\"teacher15\",\"subject\":\"subject15\",\"room\":\"room15\"}],[{\"from_hours\":\"15\",\"from_minutes\":\"10\",\"to_minutes\":\"20\",\"to_hours\":\"17\",\"weekday\":\"Tuesday\",\"$$hashKey\":\"0CV\",\"teacher\":\"teacher16\",\"subject\":\"subject16\",\"room\":\"room16\"}],[{\"from_hours\":\"15\",\"from_minutes\":\"10\",\"to_minutes\":\"20\",\"to_hours\":\"17\",\"weekday\":\"Wednesday\",\"$$hashKey\":\"0DF\",\"teacher\":\"teacher17\",\"subject\":\"subject17\",\"room\":\"room17\"}],[{\"from_hours\":\"15\",\"from_minutes\":\"10\",\"to_minutes\":\"20\",\"to_hours\":\"17\",\"weekday\":\"Thursday\",\"$$hashKey\":\"0DZ\",\"teacher\":\"teacher18\",\"subject\":\"subject18\",\"room\":\"room18\"}],[{\"from_hours\":\"15\",\"from_minutes\":\"10\",\"to_minutes\":\"20\",\"to_hours\":\"17\",\"weekday\":\"Friday\",\"$$hashKey\":\"0EJ\",\"teacher\":\"teacher19\",\"subject\":\"subject19\",\"room\":\"room19\"}],[{\"from_hours\":\"15\",\"from_minutes\":\"10\",\"to_minutes\":\"20\",\"to_hours\":\"17\",\"weekday\":\"Saturday\",\"$$hashKey\":\"0F3\",\"teacher\":\"teacher20\",\"subject\":\"subject20\",\"room\":\"room20\"}],[{\"from_hours\":\"15\",\"from_minutes\":\"10\",\"to_minutes\":\"20\",\"to_hours\":\"17\",\"weekday\":\"Sunday\",\"$$hashKey\":\"0FN\",\"teacher\":\"teacher21\",\"subject\":\"subject21\",\"room\":\"room21\"}]],[[{\"from_hours\":\"17\",\"from_minutes\":\"30\",\"to_minutes\":\"10\",\"to_hours\":\"19\",\"weekday\":\"Monday\",\"$$hashKey\":\"0GN\",\"teacher\":\"teacher22\",\"subject\":\"subject22\",\"room\":\"room22\"}],[{\"from_hours\":\"17\",\"from_minutes\":\"30\",\"to_minutes\":\"10\",\"to_hours\":\"19\",\"weekday\":\"Tuesday\",\"$$hashKey\":\"0H7\",\"teacher\":\"teacher23\",\"subject\":\"subject23\",\"room\":\"room23\"}],[{\"from_hours\":\"17\",\"from_minutes\":\"30\",\"to_minutes\":\"10\",\"to_hours\":\"19\",\"weekday\":\"Wednesday\",\"$$hashKey\":\"0HR\",\"teacher\":\"teacher24\",\"subject\":\"subject24\",\"room\":\"room24\"}],[{\"from_hours\":\"17\",\"from_minutes\":\"30\",\"to_minutes\":\"10\",\"to_hours\":\"19\",\"weekday\":\"Thursday\",\"$$hashKey\":\"0IB\",\"teacher\":\"teacher25\",\"subject\":\"subject25\",\"room\":\"room25\"}],[{\"from_hours\":\"17\",\"from_minutes\":\"30\",\"to_minutes\":\"10\",\"to_hours\":\"19\",\"weekday\":\"Friday\",\"$$hashKey\":\"0IV\",\"teacher\":\"teacher26\",\"subject\":\"subject26\",\"room\":\"room26\"}],[{\"from_hours\":\"17\",\"from_minutes\":\"30\",\"to_minutes\":\"10\",\"to_hours\":\"19\",\"weekday\":\"Saturday\",\"$$hashKey\":\"0JF\",\"teacher\":\"teacher27\",\"subject\":\"subject27\",\"room\":\"room27\"}],[{\"from_hours\":\"17\",\"from_minutes\":\"30\",\"to_minutes\":\"10\",\"to_hours\":\"19\",\"weekday\":\"Sunday\",\"$$hashKey\":\"0JZ\",\"teacher\":\"teacher28\",\"subject\":\"subject28\",\"room\":\"room28\"}]]]", "group"=>{"name"=>"dsadasdas", "group_code"=>"9A2KVG", "$$hashKey"=>"009"}}, "group_id"=>"9A2KVG"}

      	xhr :post, group_timetable_path(group),params
        expect(response.code).to eq("200")
     end
    end
  end

  describe "getting the timetable" do

    it "shoud get me the timetable for the group" do
     group = Group.create(name:"Electronics",group_code:"9A2KVG")

  
        
     params = {"timetable"=>{"members"=>@users,"entries"=>"[[[{\"from_hours\":\"09\",\"from_minutes\":\"10\",\"to_minutes\":\"20\",\"to_hours\":\"11\",\"weekday\":\"Monday\",\"$$hashKey\":\"03N\",\"teacher\":\"teacher1\",\"subject\":\"subject1\",\"room\":\"room1\"}],[{\"from_hours\":\"09\",\"from_minutes\":\"10\",\"to_minutes\":\"20\",\"to_hours\":\"11\",\"weekday\":\"Tuesday\",\"$$hashKey\":\"047\",\"teacher\":\"teacher2\",\"subject\":\"subject2\",\"room\":\"room2\"}],[{\"from_hours\":\"09\",\"from_minutes\":\"10\",\"to_minutes\":\"20\",\"to_hours\":\"11\",\"weekday\":\"Wednesday\",\"$$hashKey\":\"04R\",\"teacher\":\"teacher3\",\"subject\":\"subject3\",\"room\":\"room3\"}],[{\"from_hours\":\"09\",\"from_minutes\":\"10\",\"to_minutes\":\"20\",\"to_hours\":\"11\",\"weekday\":\"Thursday\",\"$$hashKey\":\"05B\",\"teacher\":\"teacher4\",\"subject\":\"subject4\",\"room\":\"room4\"}],[{\"from_hours\":\"09\",\"from_minutes\":\"10\",\"to_minutes\":\"20\",\"to_hours\":\"11\",\"weekday\":\"Friday\",\"$$hashKey\":\"05V\",\"teacher\":\"teacher5\",\"subject\":\"subject5\",\"room\":\"room5\"}],[{\"from_hours\":\"09\",\"from_minutes\":\"10\",\"to_minutes\":\"20\",\"to_hours\":\"11\",\"weekday\":\"Saturday\",\"$$hashKey\":\"06F\",\"teacher\":\"teacher6\",\"subject\":\"subject6\",\"room\":\"room6\"}],[{\"from_hours\":\"09\",\"from_minutes\":\"10\",\"to_minutes\":\"20\",\"to_hours\":\"11\",\"weekday\":\"Sunday\",\"$$hashKey\":\"06Z\",\"teacher\":\"teacher7\",\"subject\":\"subject7\",\"room\":\"room7\"}]],[[{\"from_hours\":\"11\",\"from_minutes\":\"30\",\"to_minutes\":\"10\",\"to_hours\":\"14\",\"weekday\":\"Monday\",\"$$hashKey\":\"07Z\",\"teacher\":\"teacher8\",\"subject\":\"subject8\",\"room\":\"room8\"}],[{\"from_hours\":\"11\",\"from_minutes\":\"30\",\"to_minutes\":\"10\",\"to_hours\":\"14\",\"weekday\":\"Tuesday\",\"$$hashKey\":\"08J\",\"teacher\":\"teacher9\",\"subject\":\"subject9\",\"room\":\"room9\"}],[{\"from_hours\":\"11\",\"from_minutes\":\"30\",\"to_minutes\":\"10\",\"to_hours\":\"14\",\"weekday\":\"Wednesday\",\"$$hashKey\":\"093\",\"teacher\":\"teacher10\",\"subject\":\"subject10\",\"room\":\"room10\"}],[{\"from_hours\":\"11\",\"from_minutes\":\"30\",\"to_minutes\":\"10\",\"to_hours\":\"14\",\"weekday\":\"Thursday\",\"$$hashKey\":\"09N\",\"teacher\":\"teacher11\",\"subject\":\"subject11\",\"room\":\"room11\"}],[{\"from_hours\":\"11\",\"from_minutes\":\"30\",\"to_minutes\":\"10\",\"to_hours\":\"14\",\"weekday\":\"Friday\",\"$$hashKey\":\"0A7\",\"teacher\":\"teacher12\",\"subject\":\"subject12\",\"room\":\"room12\"}],[{\"from_hours\":\"11\",\"from_minutes\":\"30\",\"to_minutes\":\"10\",\"to_hours\":\"14\",\"weekday\":\"Saturday\",\"$$hashKey\":\"0AR\",\"teacher\":\"teacher13\",\"subject\":\"subject13\",\"room\":\"room13\"}],[{\"from_hours\":\"11\",\"from_minutes\":\"30\",\"to_minutes\":\"10\",\"to_hours\":\"14\",\"weekday\":\"Sunday\",\"$$hashKey\":\"0BB\",\"teacher\":\"teacher14\",\"subject\":\"subject14\",\"room\":\"room14\"}]],[[{\"from_hours\":\"15\",\"from_minutes\":\"10\",\"to_minutes\":\"20\",\"to_hours\":\"17\",\"weekday\":\"Monday\",\"$$hashKey\":\"0CB\",\"teacher\":\"teacher15\",\"subject\":\"subject15\",\"room\":\"room15\"}],[{\"from_hours\":\"15\",\"from_minutes\":\"10\",\"to_minutes\":\"20\",\"to_hours\":\"17\",\"weekday\":\"Tuesday\",\"$$hashKey\":\"0CV\",\"teacher\":\"teacher16\",\"subject\":\"subject16\",\"room\":\"room16\"}],[{\"from_hours\":\"15\",\"from_minutes\":\"10\",\"to_minutes\":\"20\",\"to_hours\":\"17\",\"weekday\":\"Wednesday\",\"$$hashKey\":\"0DF\",\"teacher\":\"teacher17\",\"subject\":\"subject17\",\"room\":\"room17\"}],[{\"from_hours\":\"15\",\"from_minutes\":\"10\",\"to_minutes\":\"20\",\"to_hours\":\"17\",\"weekday\":\"Thursday\",\"$$hashKey\":\"0DZ\",\"teacher\":\"teacher18\",\"subject\":\"subject18\",\"room\":\"room18\"}],[{\"from_hours\":\"15\",\"from_minutes\":\"10\",\"to_minutes\":\"20\",\"to_hours\":\"17\",\"weekday\":\"Friday\",\"$$hashKey\":\"0EJ\",\"teacher\":\"teacher19\",\"subject\":\"subject19\",\"room\":\"room19\"}],[{\"from_hours\":\"15\",\"from_minutes\":\"10\",\"to_minutes\":\"20\",\"to_hours\":\"17\",\"weekday\":\"Saturday\",\"$$hashKey\":\"0F3\",\"teacher\":\"teacher20\",\"subject\":\"subject20\",\"room\":\"room20\"}],[{\"from_hours\":\"15\",\"from_minutes\":\"10\",\"to_minutes\":\"20\",\"to_hours\":\"17\",\"weekday\":\"Sunday\",\"$$hashKey\":\"0FN\",\"teacher\":\"teacher21\",\"subject\":\"subject21\",\"room\":\"room21\"}]],[[{\"from_hours\":\"17\",\"from_minutes\":\"30\",\"to_minutes\":\"10\",\"to_hours\":\"19\",\"weekday\":\"Monday\",\"$$hashKey\":\"0GN\",\"teacher\":\"teacher22\",\"subject\":\"subject22\",\"room\":\"room22\"}],[{\"from_hours\":\"17\",\"from_minutes\":\"30\",\"to_minutes\":\"10\",\"to_hours\":\"19\",\"weekday\":\"Tuesday\",\"$$hashKey\":\"0H7\",\"teacher\":\"teacher23\",\"subject\":\"subject23\",\"room\":\"room23\"}],[{\"from_hours\":\"17\",\"from_minutes\":\"30\",\"to_minutes\":\"10\",\"to_hours\":\"19\",\"weekday\":\"Wednesday\",\"$$hashKey\":\"0HR\",\"teacher\":\"teacher24\",\"subject\":\"subject24\",\"room\":\"room24\"}],[{\"from_hours\":\"17\",\"from_minutes\":\"30\",\"to_minutes\":\"10\",\"to_hours\":\"19\",\"weekday\":\"Thursday\",\"$$hashKey\":\"0IB\",\"teacher\":\"teacher25\",\"subject\":\"subject25\",\"room\":\"room25\"}],[{\"from_hours\":\"17\",\"from_minutes\":\"30\",\"to_minutes\":\"10\",\"to_hours\":\"19\",\"weekday\":\"Friday\",\"$$hashKey\":\"0IV\",\"teacher\":\"teacher26\",\"subject\":\"subject26\",\"room\":\"room26\"}],[{\"from_hours\":\"17\",\"from_minutes\":\"30\",\"to_minutes\":\"10\",\"to_hours\":\"19\",\"weekday\":\"Saturday\",\"$$hashKey\":\"0JF\",\"teacher\":\"teacher27\",\"subject\":\"subject27\",\"room\":\"room27\"}],[{\"from_hours\":\"17\",\"from_minutes\":\"30\",\"to_minutes\":\"10\",\"to_hours\":\"19\",\"weekday\":\"Sunday\",\"$$hashKey\":\"0JZ\",\"teacher\":\"teacher28\",\"subject\":\"subject28\",\"room\":\"room28\"}]]]", "group"=>{"name"=>"dsadasdas", "group_code"=>"9A2KVG", "$$hashKey"=>"009"}}, "group_id"=>"9A2KVG"}
     
     xhr :post, group_timetable_path(group),params
     
     xhr :get,group_timetable_path(group),group_code: "9A2KVG"
     
     expect(response.code).to eq("200")

   end

  end
end