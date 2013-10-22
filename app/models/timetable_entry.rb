class TimetableEntry < ActiveRecord::Base
	belongs_to :timetable
	validates :timetable_id, presence: true
	belongs_to :weekday
	belongs_to :subject
	belongs_to :teacher
	belongs_to :room
	belongs_to :class_timing
  belongs_to :small_group
  
  default_scope -> { includes(:room).includes(:teacher).includes(:subject)}
 
   

   def to_hash

    entry_hash = {}
    entry_hash["weekday"] = self.weekday.name
    
    entry_hash["teacher"] = self.teacher.name
    entry_hash["subject"] = self.subject.name
    entry_hash["room"] = self.room.name

  
    entry_hash["batch"] = self.small_group.name
  
    entry_hash["to_hours"] = self.class_timing.to_hours
    entry_hash["to_minutes"] = self.class_timing.to_minutes
    entry_hash["from_minutes"] = self.class_timing.from_minutes
    entry_hash["from_hours"] = self.class_timing.from_hours
    return entry_hash
   end

  
  
end
