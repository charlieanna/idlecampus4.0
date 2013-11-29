#
class ClassTiming < ActiveRecord::Base
  validate :from_is_less_than_to
  def to_hours
    to.hour.to_s
  end

  def to_minutes
    
    to.min.to_s
  end

  def from_minutes
    from.min.to_s
  end

  def from_hours
    from.hour.to_s
  end

  def self.get_time(a, b)
    hash = { hour: a.to_i, min: b.to_i }
    Time.new.utc.change(hash)
    
  end

  def self.time(entry)
    from = get_time(entry['from_hours'], entry['from_minutes'])
    to = get_time(entry['to_hours'], entry['to_minutes'])
    [from, to]
  end

  private

  def from_is_less_than_to
    errors.add(:from, 'should be less than To') if from > to
  end
end
