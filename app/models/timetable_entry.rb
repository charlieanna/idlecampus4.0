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
    puts self.id
    # if self.id == 5
 #      debugger
 #    end
 # puts self.weekday.name
#  puts self.teacher.name
#  puts self.room.name
#  puts self.class_timing
#  puts self.small_group
#  if self.class_timing.nil?
#    debugger
#  end
 
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

   def self.get(entry,timetable)
     
 
     from = Time.new.utc

     from = from.change({:hour => entry['from_hours'].to_i , :min => entry['from_minutes'].to_i })
     
     to = Time.new.utc

     to = to.change({:hour => entry['to_hours'].to_i , :min => entry['to_minutes'].to_i })




     class_timing = ClassTiming.find_or_create_by(from: from,to: to)

    
     

     small_group = SmallGroup.find_or_create_by(name: entry['batch'])
     
     
     weekday = Weekday.find_or_create_by(name: entry['weekday'])
          
     timetableentry = TimetableEntry.find_or_create_by( :weekday_id => weekday.id, :class_timing_id => class_timing.id, :small_group_id => small_group.id)
#     

     # timetableentry = TimetableEntry.new
     timetableentry.timetable = timetable
     timetableentry.save
     
     return timetableentry
   end
  
  
end
