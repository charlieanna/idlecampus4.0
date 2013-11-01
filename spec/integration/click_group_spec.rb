require_relative '../spec_helper'

feature 'Visitor signs up', :js => true do
  before do
    @user = FactoryGirl.build(:user)
  
 
  
     sign_up_with(@user.name,@user.email,"akk322")
     
    
     
     @group1 = @user.groups.build(name:'Electronics')
     # group2 = @user.groups.build(name:'Mechanical')
     
     fill_in "group",with:@group1.name
    
    
      within("#new_group") do
         click_button "creategroupbutton"
      end

    
      click_link @group1.name
     

      
end

scenario 'with valid email and password' do
 
  group = Group.create(name:"Electronics",group_code:"9A2KVG")
  
  params = {"timetable"=>{"members"=>@users,"entries"=>"[[[{\"from_hours\":\"09\",\"from_minutes\":\"10\",\"to_minutes\":\"20\",\"to_hours\":\"11\",\"batch\":\"C1\",\"weekday\":\"Monday\",\"$$hashKey\":\"07L\",\"teacher\":\"teacher1\",\"subject\":\"subject1\",\"room\":\"room1\"},{\"from_hours\":\"09\",\"from_minutes\":\"10\",\"to_minutes\":\"20\",\"to_hours\":\"11\",\"batch\":\"C2\",\"weekday\":\"Monday\",\"$$hashKey\":\"07N\",\"teacher\":\"teacher1\",\"subject\":\"subject1\",\"room\":\"room1\"},{\"from_hours\":\"09\",\"from_minutes\":\"10\",\"to_minutes\":\"20\",\"to_hours\":\"11\",\"batch\":\"C3\",\"weekday\":\"Monday\",\"$$hashKey\":\"07P\",\"teacher\":\"teacher1\",\"subject\":\"subject1\",\"room\":\"room1\"}],[{\"from_hours\":\"09\",\"from_minutes\":\"10\",\"to_minutes\":\"20\",\"to_hours\":\"11\",\"batch\":\"C1\",\"weekday\":\"Tuesday\",\"$$hashKey\":\"09B\",\"teacher\":\"teacher1\",\"subject\":\"subject1\",\"room\":\"room1\"},{\"from_hours\":\"09\",\"from_minutes\":\"10\",\"to_minutes\":\"20\",\"to_hours\":\"11\",\"batch\":\"C2\",\"weekday\":\"Tuesday\",\"$$hashKey\":\"09D\",\"teacher\":\"teacher1\",\"subject\":\"subject1\",\"room\":\"room1\"},{\"from_hours\":\"09\",\"from_minutes\":\"10\",\"to_minutes\":\"20\",\"to_hours\":\"11\",\"batch\":\"C3\",\"weekday\":\"Tuesday\",\"$$hashKey\":\"09F\",\"teacher\":\"teacher1\",\"subject\":\"subject1\",\"room\":\"room1\"}],[{\"from_hours\":\"09\",\"from_minutes\":\"10\",\"to_minutes\":\"20\",\"to_hours\":\"11\",\"weekday\":\"Wednesday\",\"$$hashKey\":\"04R\",\"teacher\":\"teacher3\",\"subject\":\"subject3\",\"room\":\"room3\"}],[{\"from_hours\":\"09\",\"from_minutes\":\"10\",\"to_minutes\":\"20\",\"to_hours\":\"11\",\"weekday\":\"Thursday\",\"$$hashKey\":\"05B\",\"teacher\":\"teacher4\",\"subject\":\"subject4\",\"room\":\"room4\"}],[{\"from_hours\":\"09\",\"from_minutes\":\"10\",\"to_minutes\":\"20\",\"to_hours\":\"11\",\"weekday\":\"Friday\",\"$$hashKey\":\"05V\",\"teacher\":\"teacher5\",\"subject\":\"subject5\",\"room\":\"room5\"}],[{\"from_hours\":\"09\",\"from_minutes\":\"10\",\"to_minutes\":\"20\",\"to_hours\":\"11\",\"weekday\":\"Saturday\",\"$$hashKey\":\"06F\",\"teacher\":\"teacher6\",\"subject\":\"subject6\",\"room\":\"room6\"}],[{\"from_hours\":\"09\",\"from_minutes\":\"10\",\"to_minutes\":\"20\",\"to_hours\":\"11\",\"weekday\":\"Sunday\",\"$$hashKey\":\"06Z\",\"teacher\":\"teacher7\",\"subject\":\"subject7\",\"room\":\"room7\"}]],[[{\"from_hours\":\"11\",\"from_minutes\":\"30\",\"to_minutes\":\"10\",\"to_hours\":\"14\",\"weekday\":\"Monday\",\"$$hashKey\":\"0BF\",\"teacher\":\"teacher8\",\"subject\":\"subject8\",\"room\":\"room8\"}],[{\"from_hours\":\"11\",\"from_minutes\":\"30\",\"to_minutes\":\"10\",\"to_hours\":\"14\",\"weekday\":\"Tuesday\",\"$$hashKey\":\"0BZ\",\"teacher\":\"teacher9\",\"subject\":\"subject9\",\"room\":\"room9\"}],[{\"from_hours\":\"11\",\"from_minutes\":\"30\",\"to_minutes\":\"10\",\"to_hours\":\"14\",\"weekday\":\"Wednesday\",\"$$hashKey\":\"0CJ\",\"teacher\":\"teacher10\",\"subject\":\"subject10\",\"room\":\"room10\"}],[{\"from_hours\":\"11\",\"from_minutes\":\"30\",\"to_minutes\":\"10\",\"to_hours\":\"14\",\"weekday\":\"Thursday\",\"$$hashKey\":\"0D3\",\"teacher\":\"teacher11\",\"subject\":\"subject11\",\"room\":\"room11\"}],[{\"from_hours\":\"11\",\"from_minutes\":\"30\",\"to_minutes\":\"10\",\"to_hours\":\"14\",\"weekday\":\"Friday\",\"$$hashKey\":\"0DN\",\"teacher\":\"teacher12\",\"subject\":\"subject12\",\"room\":\"room12\"}],[{\"from_hours\":\"11\",\"from_minutes\":\"30\",\"to_minutes\":\"10\",\"to_hours\":\"14\",\"weekday\":\"Saturday\",\"$$hashKey\":\"0E7\",\"teacher\":\"teacher13\",\"subject\":\"subject13\",\"room\":\"room13\"}],[{\"from_hours\":\"11\",\"from_minutes\":\"30\",\"to_minutes\":\"10\",\"to_hours\":\"14\",\"weekday\":\"Sunday\",\"$$hashKey\":\"0ER\",\"teacher\":\"teacher14\",\"subject\":\"subject14\",\"room\":\"room14\"}]],[[{\"from_hours\":\"15\",\"from_minutes\":\"10\",\"to_minutes\":\"20\",\"to_hours\":\"17\",\"weekday\":\"Monday\",\"$$hashKey\":\"0FR\",\"teacher\":\"teacher15\",\"subject\":\"subject15\",\"room\":\"room15\"}],[{\"from_hours\":\"15\",\"from_minutes\":\"10\",\"to_minutes\":\"20\",\"to_hours\":\"17\",\"weekday\":\"Tuesday\",\"$$hashKey\":\"0GB\",\"teacher\":\"teacher16\",\"subject\":\"subject16\",\"room\":\"room16\"}],[{\"from_hours\":\"15\",\"from_minutes\":\"10\",\"to_minutes\":\"20\",\"to_hours\":\"17\",\"weekday\":\"Wednesday\",\"$$hashKey\":\"0GV\",\"teacher\":\"teacher17\",\"subject\":\"subject17\",\"room\":\"room17\"}],[{\"from_hours\":\"15\",\"from_minutes\":\"10\",\"to_minutes\":\"20\",\"to_hours\":\"17\",\"weekday\":\"Thursday\",\"$$hashKey\":\"0HF\",\"teacher\":\"teacher18\",\"subject\":\"subject18\",\"room\":\"room18\"}],[{\"from_hours\":\"15\",\"from_minutes\":\"10\",\"to_minutes\":\"20\",\"to_hours\":\"17\",\"weekday\":\"Friday\",\"$$hashKey\":\"0HZ\",\"teacher\":\"teacher19\",\"subject\":\"subject19\",\"room\":\"room19\"}],[{\"from_hours\":\"15\",\"from_minutes\":\"10\",\"to_minutes\":\"20\",\"to_hours\":\"17\",\"weekday\":\"Saturday\",\"$$hashKey\":\"0IJ\",\"teacher\":\"teacher20\",\"subject\":\"subject20\",\"room\":\"room20\"}],[{\"from_hours\":\"15\",\"from_minutes\":\"10\",\"to_minutes\":\"20\",\"to_hours\":\"17\",\"weekday\":\"Sunday\",\"$$hashKey\":\"0J3\",\"teacher\":\"teacher21\",\"subject\":\"subject21\",\"room\":\"room21\"}]],[[{\"from_hours\":\"17\",\"from_minutes\":\"30\",\"to_minutes\":\"10\",\"to_hours\":\"19\",\"weekday\":\"Monday\",\"$$hashKey\":\"0K3\",\"teacher\":\"teacher22\",\"subject\":\"subject22\",\"room\":\"room22\"}],[{\"from_hours\":\"17\",\"from_minutes\":\"30\",\"to_minutes\":\"10\",\"to_hours\":\"19\",\"weekday\":\"Tuesday\",\"$$hashKey\":\"0KN\",\"teacher\":\"teacher23\",\"subject\":\"subject23\",\"room\":\"room23\"}],[{\"from_hours\":\"17\",\"from_minutes\":\"30\",\"to_minutes\":\"10\",\"to_hours\":\"19\",\"weekday\":\"Wednesday\",\"$$hashKey\":\"0L7\",\"teacher\":\"teacher24\",\"subject\":\"subject24\",\"room\":\"room24\"}],[{\"from_hours\":\"17\",\"from_minutes\":\"30\",\"to_minutes\":\"10\",\"to_hours\":\"19\",\"weekday\":\"Thursday\",\"$$hashKey\":\"0LR\",\"teacher\":\"teacher25\",\"subject\":\"subject25\",\"room\":\"room25\"}],[{\"from_hours\":\"17\",\"from_minutes\":\"30\",\"to_minutes\":\"10\",\"to_hours\":\"19\",\"weekday\":\"Friday\",\"$$hashKey\":\"0MB\",\"teacher\":\"teacher26\",\"subject\":\"subject26\",\"room\":\"room26\"}],[{\"from_hours\":\"17\",\"from_minutes\":\"30\",\"to_minutes\":\"10\",\"to_hours\":\"19\",\"weekday\":\"Saturday\",\"$$hashKey\":\"0MV\",\"teacher\":\"teacher27\",\"subject\":\"subject27\",\"room\":\"room27\"}],[{\"from_hours\":\"17\",\"from_minutes\":\"30\",\"to_minutes\":\"10\",\"to_hours\":\"19\",\"weekday\":\"Sunday\",\"$$hashKey\":\"0NF\",\"teacher\":\"teacher28\",\"subject\":\"subject28\",\"room\":\"room28\"}]]]", "group"=>{"name"=>"dsadasdas", "group_code"=>"9A2KVG", "$$hashKey"=>"009"}}, "group_id"=>"9A2KVG"}

	xhr :post, group_timetable_path(group),params
  expect(response.code).to eq("200")
      
      # click_link @group1.name
  end
 



# scenario 'clicks the group after creating the timetable' do
#  
#      
#       # click_link @group1.name
#   end
 
end


def click_link_def(el)
 
  page.find("##{el}").trigger(:click) 
end
def open_page
  save_and_open_page
end


   