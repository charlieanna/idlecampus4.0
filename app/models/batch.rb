class Batch < ActiveRecord::Base
  before_save :saved
  def saved
    puts "#{self} saved"
  end
end
