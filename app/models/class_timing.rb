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

  def get_time(a, b)
    hash = { hour: entry[a].to_i, min: entry[b].to_i }
    Time.new.utc.change(hash)
  end

  def self.time(entry)
    from = get_time('from_hours', 'from_minutes')
    to = get_time('to_hours', 'to_minutes')
    [from, to]
  end

  private

  def from_is_less_than_to
    errors.add(:from, 'should be less than To') if from > to
  end
end
