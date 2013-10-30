class Room < ActiveRecord::Base
	belongs_to :group
	belongs_to :timetable
  before_save :saved
  def saved
    puts "#{self} saved"
  end
	def self.in_hash(group)
		 rooms = group.teachers.pluck(:name)
		 field_entry = {}
     field_entry["name"] = "room"
     field_entry["values"] = rooms.uniq
     return field_entry
	end
end
