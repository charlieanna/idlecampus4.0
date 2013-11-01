class Teacher < ActiveRecord::Base
  before_save :saved
  def saved
    puts "#{self} saved"
  end
	belongs_to :group
	belongs_to :timetable
	def self.in_hash(group)
		 teachers = group.teachers.pluck(:name)
		 field_entry = {}
     field_entry["name"] = "teacher"
     field_entry["values"] = teachers.uniq
     return field_entry
	end
end
