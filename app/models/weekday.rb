class Weekday < ActiveRecord::Base
  before_save :saved
  def saved
    puts "#{self} saved"
  end
end
