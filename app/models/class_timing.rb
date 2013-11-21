class ClassTiming < ActiveRecord::Base
	validate :from_is_less_than_to
  before_save :saved
  def saved
    puts "#{self} saved"
  end
	def to_hours
		self.to.hour.to_s
	end

	def to_minutes
		self.to.min.to_s
	end

	def from_minutes
		self.from.min.to_s
	end

	def from_hours
		self.from.hour.to_s
	end
  
  def get_time(a,b)
    hash = {:hour => entry[a].to_i , :min => entry[b].to_i }
    Time.new.utc.change(hash)
  end
  
  def self.time(entry)

    from = get_time('from_hours','from_minutes')
    
    to = get_time('to_hours','to_minutes')

    
    
    return from,to
  end

	private

	def from_is_less_than_to
		errors.add(:from, "should be less than To") if from > to
	end

	
end
