class Group < ActiveRecord::Base
	validates :name,presence: true
    has_one :timetable
    belongs_to :user
    # has_many :user,through: :group_membership
    
  # before_save do
  #   size = 6
  #   charset = %w{ 2 3 4 6 7 9 A C D E F G H J K M N P Q R T V W X Y Z}
  # 
  #     
  #     new_group_code = (0...size).map{ charset.to_a[rand(charset.size)] }.join
  #     
  #       new_group_code = (0...size).map{ charset.to_a[rand(charset.size)] }.join  until Group.find_by_group_code(new_group_code).nil?
  #     
  #   self.group_code = new_group_code
  #     
  #   
  # end

  
end
