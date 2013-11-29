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
  after_save :send_push
  def send_push
    args = {}
    args['members'] = members
    args['message'] = message
    args['app'] = 'timetable'
    PygmentsWorker.perform_async(args)
  end

  def build_timetable_entries(entries)
    
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
  
  def get_entries
    entries = timetable_entries.includes(:class_timing).includes(:weekday).includes(:small_group)
    entries.sort do |a, b|
      a.class_timing <=> b.class_timing
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
