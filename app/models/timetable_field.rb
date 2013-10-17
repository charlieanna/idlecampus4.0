class TimetableField < ActiveRecord::Base
  belongs_to :group
  has_many :timetable_field_values
end
