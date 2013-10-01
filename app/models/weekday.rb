class Weekday < ActiveRecord::Base
  # validates_inclusion_of :name, :in => %w(Monday Tuesday Wednesday Thursday Friday Saturday Sunday)
	has_many :timetable_entries
end
