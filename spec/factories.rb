FactoryGirl.define do
  factory :user do
    name     "Michael Hartl"
  
    sequence(:email) {|n| "a#{n}@gmail.com"}
    password "foobar"
    password_confirmation "foobar"
  end
  
  factory :group do
    name "electronics"
    group_code "ABCDEF"
    association :user
  end
  
  factory :timetable do
    association :group
  end
#   
  factory :timetable_entry do
     association :timetable
     association :subject
    association :teacher
    association :weekday
  end
#   
  factory :subject do
    sequence(:name) {|n| "Subject#{n}"}
  end
#   
  factory :teacher do
     sequence(:name) {|n| "Teacher#{n}"}
  end
#   
  factory :weekday do
   sequence(:name) {|n| "Weekday#{n}"}
  end
#   
#   factory :class_timing do
#     from_hour "9"
#     from_minute "00"
#     to_hour "10"
#     to_minute "30"
#   end
#   
  
  
  
end

