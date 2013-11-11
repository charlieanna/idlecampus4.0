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
        group.stub(:get_users).and_return(@users)
        params = {"timetable"=>{"members"=>@users,"entries"=>"[[[{\"from_hours\":\"09\",\"from_minutes\":\"10\",\"to_minutes\":\"20\",\"to_hours\":\"11\",\"batch\":\"C1\",\"weekday\":\"Monday\",\"$$hashKey\":\"06B\",\"teacher\":\"teacher1\",\"subject\":\"subject1\",\"room\":\"room1\"},{\"from_hours\":\"09\",\"from_minutes\":\"10\",\"to_minutes\":\"20\",\"to_hours\":\"11\",\"batch\":\"C2\",\"weekday\":\"Monday\",\"$$hashKey\":\"06D\",\"teacher\":\"teacher1\",\"subject\":\"subject1\",\"room\":\"room1\"},{\"from_hours\":\"09\",\"from_minutes\":\"10\",\"to_minutes\":\"20\",\"to_hours\":\"11\",\"batch\":\"C3\",\"weekday\":\"Monday\",\"$$hashKey\":\"06F\",\"teacher\":\"teacher1\",\"subject\":\"subject1\",\"room\":\"room1\"}],[{\"from_hours\":\"09\",\"from_minutes\":\"10\",\"to_minutes\":\"20\",\"to_hours\":\"11\",\"batch\":\"C1\",\"weekday\":\"Tuesday\",\"$$hashKey\":\"081\",\"teacher\":\"teacher1\",\"subject\":\"subject1\",\"room\":\"room1\"},{\"from_hours\":\"09\",\"from_minutes\":\"10\",\"to_minutes\":\"20\",\"to_hours\":\"11\",\"batch\":\"C2\",\"weekday\":\"Tuesday\",\"$$hashKey\":\"083\",\"teacher\":\"teacher1\",\"subject\":\"subject1\",\"room\":\"room1\"},{\"from_hours\":\"09\",\"from_minutes\":\"10\",\"to_minutes\":\"20\",\"to_hours\":\"11\",\"batch\":\"C3\",\"weekday\":\"Tuesday\",\"$$hashKey\":\"085\",\"teacher\":\"teacher1\",\"subject\":\"subject1\",\"room\":\"room1\"}],[{\"from_hours\":\"09\",\"from_minutes\":\"10\",\"to_minutes\":\"20\",\"to_hours\":\"11\",\"weekday\":\"Wednesday\",\"$$hashKey\":\"055\",\"teacher\":\"teacher3\",\"subject\":\"subject3\",\"room\":\"room3\"}],[{\"from_hours\":\"09\",\"from_minutes\":\"10\",\"to_minutes\":\"20\",\"to_hours\":\"11\",\"weekday\":\"Thursday\",\"$$hashKey\":\"05P\",\"teacher\":\"teacher4\",\"subject\":\"subject4\",\"room\":\"room4\"}]]]", "group"=>{"name"=>"dsadasdas", "group_code"=>"9A2KVG", "$$hashKey"=>"009"}}, "group_id"=>"9A2KVG"}
    
      	xhr :post, group_timetable_path(group),params
        expect(response.code).to eq("200")
        
        
     end
    end
  end

  describe "getting the timetable",pending: true do

    it "shoud get me the timetable for the group" do
     group = Group.create(name:"Electronics",group_code:"9A2KVG")
     weekdays = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]
     rooms = FactoryGirl.build_list(:room,35)
     rooms_array = []
     rooms.each do |room|
       rooms_array << room.name
     end
     
     teachers = FactoryGirl.build_list(:teacher,35)
          teachers_array = []
          teachers.each do |teacher|
            teachers_array << teacher.name
          end
     
    
        
     params = {"timetable"=>{"members"=>@users,"entries"=>"[[[{\"from_hours\":\"09\",\"from_minutes\":\"10\",\"to_minutes\":\"20\",\"to_hours\":\"11\",\"weekday\":\"Monday\",\"$$hashKey\":\"048\",\"teacher\":\"teacher1\",\"subject\":\"subject1\",\"room\":\"room1\"}],[{\"from_hours\":\"09\",\"from_minutes\":\"10\",\"to_minutes\":\"20\",\"to_hours\":\"11\",\"weekday\":\"Tuesday\",\"$$hashKey\":\"04S\",\"teacher\":\"teacher2\",\"subject\":\"subject2\",\"room\":\"room2\"}],[{\"from_hours\":\"09\",\"from_minutes\":\"10\",\"to_minutes\":\"20\",\"to_hours\":\"11\",\"weekday\":\"Wednesday\",\"$$hashKey\":\"05C\",\"teacher\":\"teacher3\",\"subject\":\"subject3\",\"room\":\"room3\"}],[{\"from_hours\":\"09\",\"from_minutes\":\"10\",\"to_minutes\":\"20\",\"to_hours\":\"11\",\"weekday\":\"Thursday\",\"$$hashKey\":\"05W\",\"teacher\":\"teacher4\",\"subject\":\"subject4\",\"room\":\"room4\"}],[{\"from_hours\":\"09\",\"from_minutes\":\"10\",\"to_minutes\":\"20\",\"to_hours\":\"11\",\"weekday\":\"Friday\",\"$$hashKey\":\"06G\",\"teacher\":\"teacher5\",\"subject\":\"subject5\",\"room\":\"room5\"}],[{\"from_hours\":\"09\",\"from_minutes\":\"10\",\"to_minutes\":\"20\",\"to_hours\":\"11\",\"weekday\":\"Saturday\",\"$$hashKey\":\"070\",\"teacher\":\"teacher6\",\"subject\":\"subject6\",\"room\":\"room6\"}],[{\"from_hours\":\"09\",\"from_minutes\":\"10\",\"to_minutes\":\"20\",\"to_hours\":\"11\",\"weekday\":\"Sunday\",\"$$hashKey\":\"07K\",\"teacher\":\"teacher7\",\"subject\":\"subject7\",\"room\":\"room7\"}]],[[{\"from_hours\":\"11\",\"from_minutes\":\"30\",\"to_minutes\":\"10\",\"to_hours\":\"14\",\"weekday\":\"Monday\",\"$$hashKey\":\"08K\",\"teacher\":\"teacher8\",\"subject\":\"subject8\",\"room\":\"room8\"}],[{\"from_hours\":\"11\",\"from_minutes\":\"30\",\"to_minutes\":\"10\",\"to_hours\":\"14\",\"weekday\":\"Tuesday\",\"$$hashKey\":\"094\",\"teacher\":\"teacher9\",\"subject\":\"subject9\",\"room\":\"room9\"}],[{\"from_hours\":\"11\",\"from_minutes\":\"30\",\"to_minutes\":\"10\",\"to_hours\":\"14\",\"weekday\":\"Wednesday\",\"$$hashKey\":\"09O\",\"teacher\":\"teacher10\",\"subject\":\"subject10\",\"room\":\"room10\"}],[{\"from_hours\":\"11\",\"from_minutes\":\"30\",\"to_minutes\":\"10\",\"to_hours\":\"14\",\"weekday\":\"Thursday\",\"$$hashKey\":\"0A8\",\"teacher\":\"teacher11\",\"subject\":\"subject11\",\"room\":\"room11\"}],[{\"from_hours\":\"11\",\"from_minutes\":\"30\",\"to_minutes\":\"10\",\"to_hours\":\"14\",\"weekday\":\"Friday\",\"$$hashKey\":\"0AS\",\"teacher\":\"teacher12\",\"subject\":\"subject12\",\"room\":\"room12\"}],[{\"from_hours\":\"11\",\"from_minutes\":\"30\",\"to_minutes\":\"10\",\"to_hours\":\"14\",\"weekday\":\"Saturday\",\"$$hashKey\":\"0BC\",\"teacher\":\"teacher13\",\"subject\":\"subject13\",\"room\":\"room13\"}],[{\"from_hours\":\"11\",\"from_minutes\":\"30\",\"to_minutes\":\"10\",\"to_hours\":\"14\",\"weekday\":\"Sunday\",\"$$hashKey\":\"0BW\",\"teacher\":\"teacher14\",\"subject\":\"subject14\",\"room\":\"room14\"}]],[[{\"from_hours\":\"15\",\"from_minutes\":\"10\",\"to_minutes\":\"20\",\"to_hours\":\"17\",\"weekday\":\"Monday\",\"$$hashKey\":\"0CW\",\"teacher\":\"teacher15\",\"subject\":\"subject15\",\"room\":\"room15\"}],[{\"from_hours\":\"15\",\"from_minutes\":\"10\",\"to_minutes\":\"20\",\"to_hours\":\"17\",\"weekday\":\"Tuesday\",\"$$hashKey\":\"0DG\",\"teacher\":\"teacher16\",\"subject\":\"subject16\",\"room\":\"room16\"}],[{\"from_hours\":\"15\",\"from_minutes\":\"10\",\"to_minutes\":\"20\",\"to_hours\":\"17\",\"weekday\":\"Wednesday\",\"$$hashKey\":\"0E0\",\"teacher\":\"teacher17\",\"subject\":\"subject17\",\"room\":\"room17\"}],[{\"from_hours\":\"15\",\"from_minutes\":\"10\",\"to_minutes\":\"20\",\"to_hours\":\"17\",\"weekday\":\"Thursday\",\"$$hashKey\":\"0EK\",\"teacher\":\"teacher18\",\"subject\":\"subject18\",\"room\":\"room18\"}],[{\"from_hours\":\"15\",\"from_minutes\":\"10\",\"to_minutes\":\"20\",\"to_hours\":\"17\",\"weekday\":\"Friday\",\"$$hashKey\":\"0F4\",\"teacher\":\"teacher19\",\"subject\":\"subject19\",\"room\":\"room19\"}],[{\"from_hours\":\"15\",\"from_minutes\":\"10\",\"to_minutes\":\"20\",\"to_hours\":\"17\",\"weekday\":\"Saturday\",\"$$hashKey\":\"0FO\",\"teacher\":\"teacher20\",\"subject\":\"subject20\",\"room\":\"room20\"}],[{\"from_hours\":\"15\",\"from_minutes\":\"10\",\"to_minutes\":\"20\",\"to_hours\":\"17\",\"weekday\":\"Sunday\",\"$$hashKey\":\"0G8\",\"teacher\":\"teacher21\",\"subject\":\"subject21\",\"room\":\"room21\"}]],[[{\"from_hours\":\"17\",\"from_minutes\":\"30\",\"to_minutes\":\"10\",\"to_hours\":\"19\",\"weekday\":\"Monday\",\"$$hashKey\":\"0H8\",\"teacher\":\"teacher22\",\"subject\":\"subject22\",\"room\":\"room22\"}],[{\"from_hours\":\"17\",\"from_minutes\":\"30\",\"to_minutes\":\"10\",\"to_hours\":\"19\",\"weekday\":\"Tuesday\",\"$$hashKey\":\"0HS\",\"teacher\":\"teacher23\",\"subject\":\"subject23\",\"room\":\"room23\"}],[{\"from_hours\":\"17\",\"from_minutes\":\"30\",\"to_minutes\":\"10\",\"to_hours\":\"19\",\"weekday\":\"Wednesday\",\"$$hashKey\":\"0IC\",\"teacher\":\"teacher24\",\"subject\":\"subject24\",\"room\":\"room24\"}],[{\"from_hours\":\"17\",\"from_minutes\":\"30\",\"to_minutes\":\"10\",\"to_hours\":\"19\",\"weekday\":\"Thursday\",\"$$hashKey\":\"0IW\",\"teacher\":\"teacher25\",\"subject\":\"subject25\",\"room\":\"room25\"}],[{\"from_hours\":\"17\",\"from_minutes\":\"30\",\"to_minutes\":\"10\",\"to_hours\":\"19\",\"weekday\":\"Friday\",\"$$hashKey\":\"0JG\",\"teacher\":\"teacher26\",\"subject\":\"subject26\",\"room\":\"room26\"}],[{\"from_hours\":\"17\",\"from_minutes\":\"30\",\"to_minutes\":\"10\",\"to_hours\":\"19\",\"weekday\":\"Saturday\",\"$$hashKey\":\"0K0\",\"teacher\":\"teacher27\",\"subject\":\"subject27\",\"room\":\"room27\"}],[{\"from_hours\":\"17\",\"from_minutes\":\"30\",\"to_minutes\":\"10\",\"to_hours\":\"19\",\"weekday\":\"Sunday\",\"$$hashKey\":\"0KK\",\"teacher\":\"teacher28\",\"subject\":\"subject28\",\"room\":\"room28\"}]],[[{\"from_hours\":\"19\",\"from_minutes\":\"30\",\"to_minutes\":\"10\",\"to_hours\":\"21\",\"weekday\":\"Monday\",\"$$hashKey\":\"0LK\",\"teacher\":\"teacher29\",\"subject\":\"subject29\",\"room\":\"room29\"}],[{\"from_hours\":\"19\",\"from_minutes\":\"30\",\"to_minutes\":\"10\",\"to_hours\":\"21\",\"weekday\":\"Tuesday\",\"$$hashKey\":\"0M4\",\"teacher\":\"teacher30\",\"subject\":\"subject30\",\"room\":\"room30\"}],[{\"from_hours\":\"19\",\"from_minutes\":\"30\",\"to_minutes\":\"10\",\"to_hours\":\"21\",\"weekday\":\"Wednesday\",\"$$hashKey\":\"0MO\",\"teacher\":\"teacher31\",\"subject\":\"subject31\",\"room\":\"room31\"}],[{\"from_hours\":\"19\",\"from_minutes\":\"30\",\"to_minutes\":\"10\",\"to_hours\":\"21\",\"weekday\":\"Thursday\",\"$$hashKey\":\"0N8\",\"teacher\":\"teacher32\",\"subject\":\"subject32\",\"room\":\"room32\"}],[{\"from_hours\":\"19\",\"from_minutes\":\"30\",\"to_minutes\":\"10\",\"to_hours\":\"21\",\"weekday\":\"Friday\",\"$$hashKey\":\"0NS\",\"teacher\":\"teacher33\",\"subject\":\"subject33\",\"room\":\"room33\"}],[{\"from_hours\":\"19\",\"from_minutes\":\"30\",\"to_minutes\":\"10\",\"to_hours\":\"21\",\"weekday\":\"Saturday\",\"$$hashKey\":\"0OC\",\"teacher\":\"teacher34\",\"subject\":\"subject34\",\"room\":\"room34\"}],[{\"from_hours\":\"19\",\"from_minutes\":\"30\",\"to_minutes\":\"10\",\"to_hours\":\"21\",\"weekday\":\"Sunday\",\"$$hashKey\":\"0OW\",\"teacher\":\"teacher35\",\"subject\":\"subject35\",\"room\":\"room35\"}]]]", "group"=>{"name"=>"dsadasdas", "group_code"=>"9A2KVG", "$$hashKey"=>"009"}}, "group_id"=>"9A2KVG"}
   
     xhr :post, group_timetable_path(group),params
     
     
     
     xhr :get,group_timetable_path(group),group_code: "9A2KVG"
     
     result = response.body
     has = ActiveSupport::JSON.decode(result)
     
     field_entries = has["timetable"]["field_entries"]
    
    weekdays_from_entries = has["timetable"]["weekdays"]
    
    
    rooms_from_entries = []
     field_entries.each do |entry|
       if entry["name"] == "room"
         rooms_from_entries = entry["values"]
       end
     end
     
     
     expect(rooms_from_entries).to eq rooms_array
     teachers_from_entries = []
      field_entries.each do |entry|
        if entry["name"] == "teacher"
          teachers_from_entries = entry["values"]
        end
      end
     
     
      expect(teachers_from_entries).to eq teachers_array
      
      
     subjects_from_entries = []
       field_entries.each do |entry|
         if entry["name"] == "subject"
           subjects_from_entries = entry["values"]
         end
       end
     
     
       expect(teachers_from_entries).to eq teachers_array
       
       expect(weekdays_from_entries).to eq(weekdays)
       
       visit '/'
       
       # save_and_open_page
 #     
      expect(response.code).to eq("200")

   end
   
   it "creates with a batch also",pending: true do
     group = Group.create(name:"Electronics",group_code:"9A2KVG")

  
        
     params = {"timetable"=>{"members"=>@users,"entries"=>"[[[{\"from_hours\":\"09\",\"from_minutes\":\"10\",\"to_minutes\":\"20\",\"to_hours\":\"11\",\"batch\":\"C1\",\"weekday\":\"Monday\",\"$$hashKey\":\"051\",\"teacher\":\"teacher1\",\"subject\":\"subject1\",\"room\":\"room1\"},{\"from_hours\":\"09\",\"from_minutes\":\"10\",\"to_minutes\":\"20\",\"to_hours\":\"11\",\"batch\":\"C2\",\"weekday\":\"Monday\",\"$$hashKey\":\"053\",\"teacher\":\"teacher1\",\"subject\":\"subject1\",\"room\":\"room1\"},{\"from_hours\":\"09\",\"from_minutes\":\"10\",\"to_minutes\":\"20\",\"to_hours\":\"11\",\"batch\":\"C3\",\"weekday\":\"Monday\",\"$$hashKey\":\"055\",\"teacher\":\"teacher1\",\"subject\":\"subject1\",\"room\":\"room1\"}],[{\"from_hours\":\"09\",\"from_minutes\":\"10\",\"to_minutes\":\"20\",\"to_hours\":\"11\",\"batch\":\"C1\",\"weekday\":\"Tuesday\",\"$$hashKey\":\"06R\",\"teacher\":\"teacher1\",\"subject\":\"subject1\",\"room\":\"room1\"},{\"from_hours\":\"09\",\"from_minutes\":\"10\",\"to_minutes\":\"20\",\"to_hours\":\"11\",\"batch\":\"C2\",\"weekday\":\"Tuesday\",\"$$hashKey\":\"06T\",\"teacher\":\"teacher1\",\"subject\":\"subject1\",\"room\":\"room1\"},{\"from_hours\":\"09\",\"from_minutes\":\"10\",\"to_minutes\":\"20\",\"to_hours\":\"11\",\"batch\":\"C3\",\"weekday\":\"Tuesday\",\"$$hashKey\":\"06V\",\"teacher\":\"teacher1\",\"subject\":\"subject1\",\"room\":\"room1\"}]]]", "group"=>{"name"=>"dsadasdas", "group_code"=>"9A2KVG", "$$hashKey"=>"009"}}, "group_id"=>"9A2KVG"}
 
     xhr :post, group_timetable_path(group),params
    
     xhr :get,group_timetable_path(group),group_code: "9A2KVG"
     
     result = response.body
     
     has = ActiveSupport::JSON.decode(result)
     
     batches = has["timetable"]["batches"]
     
     
     expect(batches).to eq ["C1","C2","C3"]
     
     
     expect(response.code).to eq("200")
   end

  end
  
end