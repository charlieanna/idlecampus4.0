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
 
  def build_entry_hash_with_class_timing(entry_hash)
    entry_hash["to_hours"] = self.class_timing.to_hours
    entry_hash["to_minutes"] = self.class_timing.to_minutes
    entry_hash["from_minutes"] = self.class_timing.from_minutes
    entry_hash["from_hours"] = self.class_timing.from_hours
    return entry_hash
  end
  
  def build_entry_hash_with__batch_teacher_student_room(entry_hash)
    entry_hash["teacher"] = self.teacher.name
    entry_hash["subject"] = self.subject.name
     entry_hash["room"] = self.room.name
     entry_hash["batch"] = self.small_group.name
      return entry_hash
  end
  
  def build_entry_hash_with_weekday(entry_hash)
     entry_hash["weekday"] = self.weekday.name
     return entry_hash
  end

   def to_hash
     
    entry_hash = {}

    entry_hash = build_entry_hash_with_weekday(entry_hash)
     
    entry_hash = build_entry_hash_with_teacher_student_room(entry_hash)
     
    entry_hash = build_entry_hash_with_class_timing(entry_hash)
  
 
    return entry_hash
   end

   def self.get(entry,timetable)
     
 
    

     from,to = ClassTiming.time(entry)
     

     class_timing = ClassTiming.find_or_create_by(from: from,to: to)

    
     

     small_group = SmallGroup.find_or_create_by(name: entry['batch'])
     
     
     weekday = Weekday.find_or_create_by(name: entry['weekday'])
          
     timetableentry = TimetableEntry.find_or_create_by( timetable_id: timetable.id,weekday_id => weekday.id, :class_timing_id => class_timing.id, :small_group_id => small_group.id)
#     

    
     
     return timetableentry
   end
  
  
end
