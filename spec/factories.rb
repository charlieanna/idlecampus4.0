FactoryGirl.define do
  factory :user do
    sequence(:name) { |n| "ankur#{n}" }
    sequence(:email){ |n| "ankothari#{n}@gmail.com"}
    sequence(:jabber_id) { |n| "name#{n}@idlecampus.com"}
    device_identifier "dskjfnskjfnsjkdn"
    password "akk322" 
    password_confirmation "akk322"	
    end
  end


FactoryGirl.define do
	factory :group do
	  sequence(:name) { |n| "Electronics#{n}"}
	  sequence(:group_code) { |n| "Group#{n}"}
	  user
	end
end

FactoryGirl.define do
  factory :timetable do
    group
  end
end

FactoryGirl.define do
  factory :timetable_entry do
    timetable
    weekday
    teacher
    subject
    room
    class_timing
    small_group
  end
end

FactoryGirl.define do
  factory :class_timing do
    sequence(:from) do |n|
      from = Time.new.utc
      from = from.change({:hour => n%24 , :min => n%60 })
    end
    sequence(:to) do |n|
       to = Time.new.utc
       to = to.change({:hour => n%24 , :min => n%60 })
    end
    
  end

FactoryGirl.define do 
  factory :room do
    sequence(:name) {|n| "room#{n}"}
    
  end
end

FactoryGirl.define do 
  factory :weekday do
    sequence(:name) {|n| "weekday#{n}"}
    
  end
end

FactoryGirl.define do 
  factory :teacher do
    sequence(:name) {|n| "teacher#{n}"}
    
  end
end

FactoryGirl.define do 
  factory :subject do
    sequence(:name) {|n| "subject#{n}"}
    
  end
end

FactoryGirl.define do 
  factory :small_group do
    sequence(:name) {|n| "batch#{n}"}
    
  end
end


end

