class Timetable < ActiveRecord::Base
	belongs_to :group
	has_many :timetable_entries, dependent: :destroy
end
