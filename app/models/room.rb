class Room < ActiveRecord::Base
	belongs_to :group
	belongs_to :timetable
end
