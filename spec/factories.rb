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
