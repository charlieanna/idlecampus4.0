#
class Timetable < ActiveRecord::Base
  attr_accessor :message, :members
  belongs_to :group
  has_many :teachers
  has_many :subjects
  has_many :rooms
  has_many :timetable_fields
  has_many :timetable_entries, dependent: :destroy,
            include: [:class_timing, :weekday, :small_group]
            
  has_and_belongs_to_many :fields
  has_many :weekdays, through: :timetable_entries
  
  def push_params
    return { members: members,
       message: message,
       app: 'timetable' 
      }
  end
  
  
  
  def get_field_entries

    
    field_entries = []
    
    rooms_in_hash = FieldEntry.new("room",group.rooms.pluck(:name))

    field_entries << rooms_in_hash

    teachers_in_hash = FieldEntry.new("teacher",group.teachers.pluck(:name))

    field_entries << teachers_in_hash

    subjects_in_hash = FieldEntry.new("subject",group.subjects.pluck(:name))
    
  
    field_entries << subjects_in_hash

    return field_entries
    
  end
  
  def get_entries_array
    
    entries = get_entries
    if entries.length > 0

         entries_array = []

   
         # entries_sorted_by_weekday_and_class_timings = entries.group_by {|entry| [entry.weekday,entry.class_timing]}.values
         entries_sorted_by_weekday_and_class_timings = entries.group_by do
           |entry| [entry.weekday, entry.class_timing]
          end
         entries_sorted_by_weekday_and_class_timings_each_entry_in_hash = entries_sorted_by_weekday_and_class_timings
      
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
  #    
    end
  
 def get_entries
   entries = timetable_entries
   entries.sort do |a, b|

     a.class_timing <=> b.class_timing


   end
   return entries
 end
  
  def build_timetable_entries(entries)
    PygmentsWorker.perform_async(push_params)
    entries.each do |ent|
      ent.each do |en|
        en.each do |entry|
          timetableentry = TimetableEntry.get(entry, self)
          
          entry.each do |key, value|
            create_field(timetableentry, key, value)
            timetableentry.save
          end
        end
      end
    end
  end

  def create_field(timetableentry, key, value)
    if key != 'from_hours' && key != 'from_minutes' && key != 'to_minutes' && key != 'to_hours' && key != 'weekday' && key != '$$hashKey' && key != 'batch'
      teacher = Teacher.find_or_create_by(name: value, group: group) if key == 'teacher'
      subject = Subject.find_or_create_by(name: value, group: group) if key == 'subject'
      room = Room.find_or_create_by(name: value, group: group) if key == 'room'
      timetableentry.subject = subject if key == 'subject'
      timetableentry.teacher = teacher if key == 'teacher'
      timetableentry.room = room if key == 'room'
      timetableentry.save
      
    end
  end
  

end
