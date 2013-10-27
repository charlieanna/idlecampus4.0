module Features
  module SessionHelpers
    def sign_up_with(name,email,password)

      visit signup_path
      fill_in "Name",with:name
      fill_in "Email",with:email
      fill_in "Password",with:password
      click_button "Create Account"
    end

    def sign_in_as(user, options={})
      if options[:no_capybara]
        remember_token = User.new_remember_token
        cookies[:remember_token] = remember_token
        user.update_attribute(:remember_token, User.encrypt(remember_token))
      else  
        fill_in "session_email",with: user.email
        fill_in "session_password",with:user.password
        within("#login-content") do
          click_button "Login"
        end
      end
    end

    def create_group(group)
      fill_in "Group Name",with:group.name
      within("#new_group") do
        click_button "Create"
      end
    end


    def log_out
      click_button "Sign out"
    end

    def click_group(group)
      click_link group.name
    end
    
    def add_teacher(teacher)
      fill_in "Teacher",with: "Debasis"
      within "#teachers" do
        click_button "Add"
      end
    end

    def check_weekday(weekday)
      check weekday
    end

    def add_batch(batch)
      fill_in "Batch",with: "C1"
      click "Add Batch"
    end

    def add_subject(subject)
      fill_in "Subject",with: subject
      within "#subjects" do
        click_button "Add"
      end
    end

    def add_room(room)
      fill_in "Room",with: room
      within "#rooms" do
        click_button "Add"
      end
    end

    def add_to_time
      select '9', :from => 'from_hour'
      select '10', :from => 'from_minutes'
    end

    def add_from_time
      select '9', :from => 'to_hour'
      select '10', :from => 'to_minutes'
    end
  end
end