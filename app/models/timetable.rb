class Timetable < ActiveRecord::Base
  attr_accessor :message, :members
  belongs_to :group
  has_many :teachers
  has_many :subjects
  has_many :rooms
  has_many :timetable_fields
  has_many :timetable_entries, dependent: :destroy, include: [:class_timing,:weekday,:small_group]
  has_and_belongs_to_many :fields
  has_many :weekdays, through: :timetable_entries
  

  after_save :send_push


  def send_push
    # PygmentsWorker.perform_async(self)
    Push.new(@members, @message).delay.send_push
  end

  def build_timetable_entries(entries)
     entries.each do |ent|

      ent.each do |en|

        en.each do |entry|

          from = Time.new.utc

          from = from.change({:hour => entry['from_hours'].to_i , :min => entry['from_minutes'].to_i })

          to = Time.new.utc

          to = to.change({:hour => entry['to_hours'].to_i , :min => entry['to_minutes'].to_i })




          class_timing = ClassTiming.find_or_create_by(from: from,to: to)

         
          
     
          small_group = SmallGroup.find_or_create_by(name: entry['batch'])

          weekday = Weekday.find_or_create_by(name: entry['weekday'])



          timetableentry = TimetableEntry.find_or_create_by(:timetable_id => self.id, :weekday_id => weekday.id, :class_timing_id => class_timing.id, :small_group_id => small_group.id)



          entry.each do
          |key, value|
             

         
          

          create_field(timetableentry, key, value)

          timetableentry.save

          end


        end
      end
    end
  end




  


  def create_field(timetableentry, key, value)
    if key != "from_hours" && key != "from_minutes" && key != "to_minutes" && key != "to_hours" && key != "weekday" && key != "$$hashKey" && key != "batch"
     
      teacher = Teacher.find_or_create_by(name: value,group:self.group) if key == "teacher"

      subject = Subject.find_or_create_by(name: value,group:self.group) if key == "subject" 

      room = Room.find_or_create_by(name: value,group:self.group) if key == "room" 

      timetableentry.subject = subject if key == "subject"

      timetableentry.teacher = teacher if key == "teacher"

      timetableentry.room = room if key == "room"

      timetableentry.save



    end
  end




  def get_entries
    entries = self.timetable_entries.includes(:class_timing).includes(:weekday).includes(:small_group)
    entries.sort do |a, b|

      a.class_timing <=> b.class_timing


    end
    return entries
  end

  def get_field_entry(name,values)
      
    field_entry = {}
    field_entry["name"] = name
    field_entry["values"] = values.uniq
    field_entry
  end

  def get_entry_hash_with_field(entry_hash,field)
    teacher = field.teacher
    subject = field.subject
    room = field.room
    entry_hash["teacher"] = teacher.name
    entry_hash["subject"] = subject.name
    entry_hash["room"] = room.name 
    entry_hash
  end







  def timetable_in_hash

    
    group = self.group

    teachers = group.teachers.pluck(:name)
    
    subjects = group.subjects.pluck(:name)

    rooms = group.teachers.pluck(:name)

     field_entries = []
  


     field_entry = {}
     field_entry["name"] = "room"
     field_entry["values"] = rooms.uniq
     field_entries << field_entry
  
 
    #  entry_hash["teachers"] = "teachers"
    field_entry = {}
    field_entry["name"] = "teacher"
    field_entry["values"] = teachers.uniq
    field_entries << field_entry
  

  
    #  entry_hash["subjects"] = "subjects" 
    field_entry = {}
    field_entry["name"] = "subject"
    field_entry["values"] = subjects.uniq
    field_entries << field_entry
    
    weekdays = []
    batches = []
  
    
    entries = get_entries


    if entries.length > 0

      f = []
      entries_array = []

      
      entries = get_entries


      check = []
      i = 0
      p "LLLLLLEEEEEE"
      p entries.length

      while i < entries.length
        e = []
        #fir st sort the elements baed on the classtimings only. and then group basd on them and then do the below sorting
        #each element has not been met with the condition so found = false. and when the condition meets we have found a match and we add the element t an array that met the condn.
        # but we dont add the parent element
        found = false
        entry = entries[i]


        a = entry


        j = i
       

        while j < entries.length

          b = entries[j]


          if a.weekday == b.weekday and a.class_timing == b.class_timing && a.small_group != b.small_group
            found = true
            entry_hash = {}
            entry_hash["weekday"] = b.weekday.name
            weekdays << b.weekday.name
            teacher = b.teacher
            subject = b.subject
            room = b.room
            
             
              
              entry_hash["teacher"] = teacher.name
              entry_hash["subject"] = subject.name
              entry_hash["room"] = room.name

            #   field_entry = {}
            #   field_entry["name"] = field.table_name
            #   field_entry["values"] = field.uniq.pluck(:name)
            #   field_entries << field_entry
            # end
            entry_hash["batch"] = b.small_group.name
            batches << b.small_group.name
            entry_hash["to_hours"] = b.class_timing.to_hours
            entry_hash["to_minutes"] = b.class_timing.to_minutes
            entry_hash["from_minutes"] = b.class_timing.from_minutes
            entry_hash["from_hours"] = b.class_timing.from_hours
            e << entry_hash

            check << entry_hash
          end
          j = j + 1
        end
        #agar ek baar bhi true hua toh element ko array me daaldo. aur agar found nahi mila toh usey seedhe parent array me daalo
        if found
          entry_hash = {}
          entry_hash["weekday"] = a.weekday.name
          weekdays << a.weekday.name
           teacher = b.teacher
            subject = b.subject
            room = b.room
            entry_hash["teacher"] = teacher.name
            entry_hash["subject"] = subject.name
            entry_hash["rooms"] = room.name
            
          entry_hash["batch"] = a.small_group.name
          batches << a.small_group.name
          entry_hash["to_hours"] = a.class_timing.to_hours
          entry_hash["to_minutes"] = a.class_timing.to_minutes
          entry_hash["from_minutes"] = a.class_timing.from_minutes
          entry_hash["from_hours"] = a.class_timing.from_hours
          e << entry_hash

          check << entry_hash
          #p e
          entries_array << e
          #p entries_array
        else

          entry_hash = {}
          entry_hash["weekday"] = a.weekday.name
          weekdays << a.weekday.name
          teacher = a.teacher
          subject = a.subject
          room = a.room
          entry_hash["teacher"] = teacher.name
          entry_hash["subject"] = subject.name
          entry_hash["room"] = room.name
           
          entry_hash["batch"] = a.small_group.name
          batches << a.small_group.name
          entry_hash["to_hours"] = a.class_timing.to_hours
          entry_hash["to_minutes"] = a.class_timing.to_minutes
          entry_hash["from_minutes"] = a.class_timing.from_minutes
          entry_hash["from_hours"] = a.class_timing.from_hours
          #p e
          #p entry_hash
          #p check
          if check.include?(entry_hash)
            #p "AAAAAAAAAA"
          else
            e << entry_hash
            #p entries_array
            entries_array << e
          end
        end
        i = i + 1
      end

      #now group all the entries with same class_timings together and put them in the array
      #find the first element of this array and then compare it to the i + 1 element ka first array
      #  compare the class_timings of both these elements. if they are same then put them in a same array
      #p "LLLLLLLLLLLLL"
      p entries_array
      i = 0
      while i < entries_array.length
        #loop thru each element

        a = entries_array[i]
        p "AAAAAAAAA"

        #p entries_array
        p a
        first_element_a = a[0]
        arr = []
        isFound = true
        j = i + 1
        p i
        p j
        p entries_array.length
        while isFound && j < entries_array.length
          p j
          b = entries_array[j]
          #p "BBBBBBBBB"
          #p a
          #p b
          first_element_b = b[0]
          if first_element_a["to_hours"] == first_element_b["to_hours"] && first_element_a["to_minutes"] == first_element_b["to_minutes"] && first_element_a["from_minutes"] == first_element_b["from_minutes"] && first_element_a["from_hours"] == first_element_b["from_hours"]


            arr.insert(0, b)


            p "ARRAY"
            p arr
            entries_array.delete(b)
            p entries_array
            #j = j - 1
          else
            entries_array.delete(a)
            p entries_array
            arr.insert(0, a)
            p "ELSE ARRAY"
            p arr
            #entries_array[i] = arr
            entries_array.insert(i, arr)
            p entries_array
            i = i + 1
            isFound = false
          end
        end
        if j == entries_array.length
          arr.insert(0, a)
          p "BREAK ARRAY"
          p arr
          entries_array[i] = arr
          break
        end


      end
      p "MMMMMMMMMMMM"
      p entries_array
    end
    timetable_hash = {}
    entries_hash = {}
    entries_hash["group_code"] = self.group.group_code
    entries_hash["field_entries"] = field_entries.uniq
    entries_hash["entries"] = entries_array
    entries_hash["weekdays"] = weekdays.uniq
    entries_hash["batches"] = batches.uniq.compact
    timetable_hash["timetable"] = entries_hash
    @timetable = ActiveSupport::JSON.encode(timetable_hash)
  end

end
