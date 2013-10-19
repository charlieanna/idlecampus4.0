class ClassTiming < ActiveRecord::Base
	validate :from_is_less_than_to

	private

	def from_is_less_than_to
		errors.add(:from, "should be less than to") if from > to
	end
end
