#
class Subject < ActiveRecord::Base
  belongs_to :group
  belongs_to :timetable
	def self.in_hash(group)
		subjects = group.subjects.pluck(:name)
		 field_entry = {}
     field_entry["name"] = "subject"
     field_entry["values"] = subjects.uniq
     return field_entry
	end
end


