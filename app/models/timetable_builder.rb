#
class TimetableBuilder
  def initialize(group)
    @group = group
    @timetable = group.timetable
  end

  def get_entries
    entries = @timetable.timetable_entries
    entries.sort do |a,  b|
      a.class_timing <=> b.class_timing
    end
  end

  def get_field_entries
    rooms = @group.rooms.pluck(:name)
    subjects = group.subjects.pluck(:name)
    teachers = group.teachers.pluck(:name)
    rooms_in_hash = FieldEntry.new('room', rooms).to_hash
    teachers_in_hash = FieldEntry.new('teacher', teachers).to_hash
    subjects_in_hash = FieldEntry.new('subject', subjects).to_hash
    [rooms_in_hash, teachers_in_hash, subjects_in_hash]
  end

  def build
    weekdays = []
    batches = []
    timetable_hash = {}
    entries_hash = {}
    entries_hash['group_code'] = @group.group_code
    if @timetable.nil?
      field_entries = []
    else
      field_entries = get_field_entries
      entries = get_entries
      entries.each do |entry|
        weekdays << entry.weekday.name
      end
      weekdays.uniq!
      entries.each do |entry|
        batches << entry.small_group.name
      end
      batches.uniq!
      entries_array = get_entries_array(entries)
      entries_hash['entries'] = entries_array
    end
    entries_hash['field_entries'] = field_entries.uniq
    entries_hash['weekdays'] = weekdays.uniq
    entries_hash['batches'] = batches.uniq.compact
    timetable_hash['timetable'] = entries_hash
    @timetable = ActiveSupport::JSON.encode(timetable_hash)
  end

  def get_entries_array(entries)
    entries_sorted_by_weekday_and_class_timings = entries.group_by do
     |entry| [entry.weekday, entry.class_timing]
    end
    entries_sorted_by_weekday_and_class_timings.values.each do |el|
      el.map! do |e|
        e.to_hash
      end
    end
    entries_sorted_by_weekday_and_class_timings.group_by do |entry|
      [entry[0]['to_hours'],
       entry[0]['to_minutes'],
       entry[0]['from_hours'],
       entry[0]['from_minutes']]
    end
    entries_sorted_by_weekday_and_class_timings.values
  end
end
