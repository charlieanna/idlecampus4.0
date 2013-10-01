FactoryGirl.define do
  factory :user do
    name     "Michael Hartl"
    email    "michael@example.com"
    password "foobar"
    password_confirmation "foobar"
  end
  
  factory :group do
    name "electronics"
    group_code "ABCDEF"
  end
  
  factory :timetable do
    association :group
  end
  
  factory :timetable_entry do
    association :timetable
  end
  
  factory :subject do
    sequence "subject#{n}"
  end
  
  factory :teacher do
    sequence "subject#{n}"
  end
  
  factory :weekday do
    name "Monday"
  end
  
  
end

