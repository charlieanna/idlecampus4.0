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
  
  def self.time(entry)

    

    from = Time.new.utc.change({:hour => entry['from_hours'].to_i , :min => entry['from_minutes'].to_i })
    
   

    to = Time.new.utc.change({:hour => entry['to_hours'].to_i , :min => entry['to_minutes'].to_i })
    
    return from,to
  end

	private

	def from_is_less_than_to
		errors.add(:from, "should be less than To") if from > to
	end

	
end
