class Entry
	def initialize(entry)
		@entry = entry
		@weekdays = []
		@batches = []
	end

	def in_hash
		weekdays = []
    batches = []
		entry_hash = {}
    entry_hash["weekday"] = @entry.weekday.name
    
    teacher = @entry.teacher
    subject = @entry.subject
    room = @entry.room
    entry_hash["teacher"] = teacher.name
    entry_hash["subject"] = subject.name
    entry_hash["room"] = room.name

  
    entry_hash["batch"] = @entry.small_group.name
    batches << @entry.small_group.name
    entry_hash["to_hours"] = @entry.class_timing.to_hours
    entry_hash["to_minutes"] = @entry.class_timing.to_minutes
    entry_hash["from_minutes"] = @entry.class_timing.from_minutes
    entry_hash["from_hours"] = @entry.class_timing.from_hours
    return entry_hash
	end
end