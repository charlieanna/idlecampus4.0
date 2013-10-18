class TimetableField < ActiveRecord::Base
  belongs_to :group
  belongs_to :timetable
  has_many :timetable_field_values
  
end
