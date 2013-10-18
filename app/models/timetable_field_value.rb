class TimetableFieldValue < ActiveRecord::Base
  belongs_to :timetable_field
  belongs_to :timetable_entries
end
