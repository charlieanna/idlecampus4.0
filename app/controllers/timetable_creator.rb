#
class TimetableCreator
  def initialize(params)
    @params = params
    # result = parse
 #    group = Group.find_by_group_code(result['group_code'])
 #    @timetable = Timetable.find_or_create_by(group_id: group.id)
 #    @entries = result['entries']
 #    members = group.get_users
 #    @timetable.members = members
 #    message = "http://idlecampus.com/groups/#{result['group_code']}/timetable.json"
 #    @timetable.message = message
   
    
  end

  def parse
    result = {}
    group = @params['group_id']
    result['group_code'] = group
    entries = ActiveSupport::JSON.decode(@params['timetable']['entries'])
    result['entries'] = entries
    members = @params['timetable']['members']
    result['members'] = members
    return result
  end
  
  def push_params
    return { from: @params['group_id'],
      from: members: @timetable.members,
       message: @timetable.message,
       app: 'timetable' 
      }
  end
  
  def build
    entries = @entries
    PygmentsWorker.perform_async(push_params)
    entries.each do |ent|
      ent.each do |en|
        en.each do |entry|
          timetableentry = TimetableEntry.get(entry, @timetable)
          
          entry.each do |key, value|
            create_field(timetableentry, key, value)
            timetableentry.save
          end
        end
      end
    end
    @timetable.save
  end

  def create_field(timetableentry, key, value)
    if key != 'from_hours' && key != 'from_minutes' && key != 'to_minutes' && key != 'to_hours' && key != 'weekday' && key != '$$hashKey' && key != 'batch'
      teacher = Teacher.find_or_create_by(name: value, group: @group) if key == 'teacher'
      subject = Subject.find_or_create_by(name: value, group: @group) if key == 'subject'
      room = Room.find_or_create_by(name: value, group: @group) if key == 'room'
      timetableentry.subject = subject if key == 'subject'
      timetableentry.teacher = teacher if key == 'teacher'
      timetableentry.room = room if key == 'room'
      timetableentry.save
      
    end
  end
  


  def get_field_entry(name, values)
    field_entry = {}
    field_entry['name'] = name
    field_entry['values'] = values.uniq
    field_entry
  end

  def get_entry_hash_with_field(entry_hash, field)
    teacher = field.teacher
    subject = field.subject
    room = field.room
    entry_hash['teacher'] = teacher.name
    entry_hash['subject'] = subject.name
    entry_hash['room'] = room.name
    entry_hash
  end
end
