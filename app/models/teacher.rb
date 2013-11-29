#
class Teacher < ActiveRecord::Base
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