class Field < ActiveRecord::Base
  has_and_belongs_to_many :timetable_entries
   has_and_belongs_to_many :timetables
end
