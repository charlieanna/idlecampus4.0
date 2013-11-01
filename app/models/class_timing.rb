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

	private

	def from_is_less_than_to
		errors.add(:from, "should be less than To") if from > to
	end

	
end
