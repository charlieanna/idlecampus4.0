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
  
  delegate :to_hours, :to_minutes, :from_minutes, :from_hours, to: :class_timing
  
  
  default_scope -> { includes(:room).includes(:teacher).includes(:subject) }
  
  def to_hash
    TimetableEntrySerializer.new(self).serializable_hash.as_json
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
