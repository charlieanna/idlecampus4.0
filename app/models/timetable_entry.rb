#
class TimetableEntry < ActiveRecord::Base
  belongs_to :timetable
  validates :timetable_id, presence: true
  belongs_to :weekday
  belongs_to :subject
  belongs_to :teacher
  belongs_to :room
  belongs_to :class_timing
  belongs_to :small_group

  default_scope -> { includes(:room).includes(:teacher).includes(:subject) }

  def to_hash
    entry_hash = {}
    entry_hash['to_hours'] = class_timing.to_hours
    entry_hash['to_minutes'] = class_timing.to_minutes
    entry_hash['from_minutes'] = class_timing.from_minutes
    entry_hash['from_hours'] = class_timing.from_hours
    entry_hash['teacher'] = teacher.name
    entry_hash['subject'] = subject.name
    entry_hash['room'] = room.name
    entry_hash['batch'] = small_group.name
    entry_hash['weekday'] = weekday.name
  end

  def self.get(entry, timetable)
    from, to = ClassTiming.time(entry)
    class_timing = ClassTiming.find_or_create_by(from: from, to: to)
    small_group = SmallGroup.find_or_create_by(name: entry['batch'])
    weekday = Weekday.find_or_create_by(name: entry['weekday'])
    TimetableEntry.find_or_create_by(timetable_id: timetable.id,
                                     weekday_id: weekday.id,
                                     class_timing_id: class_timing.id,
                                     small_group_id: small_group.id)
  end
end
