class TimetableBuilder 

	def initialize(group)
    @group = group
		@timetable = group.timetable
		
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
   
    
    timetable_hash = {}
    entries_hash = {}
    
    puts @timetable.group
    puts @timetable.group.group_code
    entries_hash["group_code"] = @timetable.group.group_code
    entries_hash["field_entries"] = field_entries.uniq
    entries_hash["entries"] = entries_array
    entries_hash["weekdays"] = weekdays.uniq
    entries_hash["batches"] = batches.uniq.compact
    timetable_hash["timetable"] = entries_hash
    puts timetable_hash
    @timetable = ActiveSupport::JSON.encode(timetable_hash)
    return @timetable
  end
end

def get_entries_array(entries)
  
  batches = []
  weekdays = []
     if entries.length > 0

      # f = []
      entries_array = []

      
      
      # 
      # 
      # check = []
      # i = 0
      

      # entries.each_index do |i|
      #   e = []
      #   #fir st sort the elements baed on the classtimings only. and then group basd on them and then do the below sorting
      #   #each element has not been met with the condition so found = false. and when the condition meets we have found a match and we add the element t an array that met the condn.
      #   # but we dont add the parent element
      #   found = false
      #   entry = entries[i]
      # 
      #   a = entry
      # 
      # 
      #   j = i
      #  
      #   
      #   while j < entries.length
      # 
      #     b = entries[j]
      # 
      #   
      #     if a.weekday == b.weekday and a.class_timing == b.class_timing && a.small_group != b.small_group
      #       found = true
      #       entry_hash = b.to_hash
      #     
      #      
      #       e << entry_hash
      # 
      #       check << entry_hash
      #     end
      #     j = j + 1
      #   end
      #   
      #   entries_sorted_by_weekday_and_class_timings = entries.group_by {|entry| [entry.weekday,entry.class_timing]}.values
      #   
      #   entries_sorted_by_weekday_and_class_timings_each_entry_in_hash = entries_sorted_by_weekday_and_class_timings.each do |el|
      #      el.map! do |e|
      #       e.to_hash
      #     end
      #   end
      #   
      #   
      #   #agar ek baar bhi true hua toh element ko array me daaldo. aur agar found nahi mila toh usey seedhe parent array me daalo
      #   if found
      # 
      #     entry_hash = a.to_hash
      #     
      #    
      #    
      #       teacher = b.teacher
      #       subject = b.subject
      #       room = b.room
      #       entry_hash["teacher"] = teacher.name
      #       entry_hash["subject"] = subject.name
      #       entry_hash["rooms"] = room.name
      #       
      #     
      #     batches << a.small_group.name
      #      weekdays << a.weekday.name
      #     e << entry_hash
      # 
      #     check << entry_hash
      #     #p e
      #     entries_array << e
      #     #p entries_array
      #     
      #   else
      #     entry_hash = a.to_hash
      #    
      #     
      #     if check.include?(entry_hash)
      #       #p "AAAAAAAAAA"
      #     else
      #       e << entry_hash
      #       #p entries_array
      #       entries_array << e
      #     end
      #   end
      #   i = i + 1
      # end

      #now group all the entries with same class_timings together and put them in the array
      #find the first element of this array and then compare it to the i + 1 element ka first array
      #  compare the class_timings of both these elements. if they are same then put them in a same array
      #p "LLLLLLLLLLLLL"
      entries_sorted_by_weekday_and_class_timings = entries.group_by {|entry| [entry.weekday,entry.class_timing]}.values
      
      entries_sorted_by_weekday_and_class_timings_each_entry_in_hash = entries_sorted_by_weekday_and_class_timings.each do |el|
         el.map! do |e|
          e.to_hash
        end
      end
      entries_array = entries_sorted_by_weekday_and_class_timings_each_entry_in_hash
      
      
     entries_sorted_by_weekday_and_class_timings_each_entry_in_hash_sorted_by_class_timings =  entries_sorted_by_weekday_and_class_timings_each_entry_in_hash.group_by {|entry| 
        [entry[0]["to_hours"],entry[0]["to_minutes"],entry[0]["from_hours"],entry[0]["from_minutes"]]
      }.values
      
      # i = 0
 #      while i < entries_array.length
 #        #loop thru each element
 # 
 #        a = entries_array[i]
 #       
 #        first_element_a = a[0]
 #        arr = []
 #        isFound = true
 #        j = i + 1
 #       
 #        while isFound && j < entries_array.length
 #         
 #          b = entries_array[j]
 #         
 #          first_element_b = b[0]
 #          if first_element_a["to_hours"] == first_element_b["to_hours"] && first_element_a["to_minutes"] == first_element_b["to_minutes"] && first_element_a["from_minutes"] == first_element_b["from_minutes"] && first_element_a["from_hours"] == first_element_b["from_hours"]
 # 
 # 
 #            arr.insert(0, b)
 # 
 # 
 #            
 #            entries_array.delete(b)
 #          
 #          else
 #            
 #            entries_array.delete(a)
 #            p entries_array
 #            arr.insert(0, a)
 #            
 #            entries_array.insert(i, arr)
 #           
 #            i = i + 1
 #            isFound = false
 #          end
 #        end
 #        if j == entries_array.length
 #          arr.insert(0, a)
 #         
 #          entries_array[i] = arr
 #          break
 #        end
 # 
 # 
 #      end
      
    end
     
    return entries_sorted_by_weekday_and_class_timings_each_entry_in_hash_sorted_by_class_timings
  end

end