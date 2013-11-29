class TimetableSerializer < ActiveModel::Serializer
  attributes :group_code,:weekdays,:batches,:field_entries,:entries
  #has_many :timetable_entries,key: :entries
  # has_many :batches
  # has_many :weekdays
  # entries_hash["group_code"] = @timetable.group.group_code
 #  entries_hash["field_entries"] = field_entries.uniq
 #  entries_hash["entries"] = entries_array
 #  entries_hash["weekdays"] = weekdays.uniq
 #  entries_hash["batches"] = batches.uniq.compact
 #  timetable_hash["timetable"] = entries_hash
 def group_code
   object.group.group_code
 end
 
 def entries
    object.get_entries_array
 end
 
 def batches
   batches = []
   
   object.timetable_entries.each do |entry|
     batches << entry.small_group.name
   end
   batches.uniq!
 end
 

 def weekdays
   weekdays = []
   
   object.timetable_entries.each do |entry|
     weekdays << entry.weekday.name
   end
  weekdays.uniq!
 end
 
 def field_entries
   object.get_field_entries
 end


end
