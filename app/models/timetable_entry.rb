class TimetableEntry < ActiveRecord::Base
	belongs_to :timetable
	validates :timetable_id, presence: true
	belongs_to :weekday
	belongs_to :subject
	belongs_to :teacher
	belongs_to :room
	belongs_to :class_timing
  belongs_to :small_group
end
