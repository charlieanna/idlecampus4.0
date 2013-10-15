require "spec_helper"

describe "Timetable Page" do
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
  	before { visit root_path }

  	describe "with valid information" do
      it " should create the timetable" do
      	# page.execute_script("$('.the-button-selector').click();")
       # check "monday"
       click_button "Create Timetable"
       
       # page.execute_script("$('#myModal').modal(options)")
     end
    end
  end
end