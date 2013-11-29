class TimetableBuilder 

	def initialize(options)
    group = options['group_id']
    @group = Group.find_by_group_code(group)
    @timetable = @group.timetable
		
	end

	 def get_entries
    entries = @timetable.timetable_entries
    entries.sort do |a, b|
 
      a.class_timing <=> b.class_timing
 
 
    end
    return entries
  end

  def get_field_entries

    
    field_entries = []

    rooms_in_hash = Room.in_hash(@group)

    field_entries << rooms_in_hash

    
    teachers_in_hash = Teacher.in_hash(@group)

    field_entries << teachers_in_hash

    subjects_in_hash = Subject.in_hash(@group)
    
  
    field_entries << subjects_in_hash

    
    
    return field_entries
    
  end
  
  

	def build
    
    
    
		if @timetable.nil?
			weekdays = []
	    batches = []
	    field_entries = []
	 
	    timetable_hash = {}
	    entries_hash = {}

	    entries_hash["group_code"] = @group.group_code
	    entries_hash["field_entries"] = field_entries.uniq
	   
	    entries_hash["weekdays"] = weekdays.uniq
	    entries_hash["batches"] = batches.uniq.compact
	    timetable_hash["timetable"] = entries_hash
	    @timetable = ActiveSupport::JSON.encode(timetable_hash)
		
      return @timetable
    
   else
     
    field_entries = get_field_entries
    
    entries = get_entries
    
    weekdays = []
    
    entries.each do |entry|
      weekdays << entry.weekday.name
    end
    weekdays.uniq!
    batches = []
    
    entries.each do |entry|
      batches << entry.small_group.name
    end
    batches.uniq!
    
  
    
    

    entries_array = get_entries_array(entries)
    
    puts entries_array
    timetable_hash = {}
    entries_hash = {}
  
    entries_hash["group_code"] = @timetable.group.group_code
    entries_hash["field_entries"] = field_entries.uniq
    entries_hash["entries"] = entries_array
    entries_hash["weekdays"] = weekdays.uniq
    entries_hash["batches"] = batches.uniq.compact
    timetable_hash["timetable"] = entries_hash
    puts timetable_hash
    return timetable_hash
  end
end

def get_entries_array(entries)
    
    
  if entries.length > 0

       entries_array = []

   
       # entries_sorted_by_weekday_and_class_timings = entries.group_by {|entry| [entry.weekday,entry.class_timing]}.values
       entries_sorted_by_weekday_and_class_timings = entries.group_by do
         |entry| [entry.weekday, entry.class_timing]
        end
       entries_sorted_by_weekday_and_class_timings_each_entry_in_hash = entries_sorted_by_weekday_and_class_timings.values.each do |el|
         
          el.map! do |e|
            
            e.to_hash
           
         end
       end
      
       
    
   
      
     end
     
     entries_sorted_by_weekday_and_class_timings_each_entry_in_hash_sorted_by_class_timings = entries_sorted_by_weekday_and_class_timings_each_entry_in_hash.group_by do |entry|
          [entry[0]['to_hours'],
           entry[0]['to_minutes'],
           entry[0]['from_hours'],
           entry[0]['from_minutes']]
        end
        entries_sorted_by_weekday_and_class_timings_each_entry_in_hash_sorted_by_class_timings.values
     
  end
 

  
 
end
