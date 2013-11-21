class Teacher < ActiveRecord::Base
  belongs_to :group
  belongs_to :timetable
end