class Group < ActiveRecord::Base
	validates :name,presence: true
    has_one :timetable
    has_many :timetable_fields
    belongs_to :user
    has_many :teachers
    has_many :subjects
    has_many :rooms
    
    # has_many :user,through: :group_membership
    
    def  self.get_group_code
      groups = Group.all
      group_codes = []
      groups.each do |group|
        group_codes << group.group_code
      end
      p group_codes
      new_group_code = generate_group_code
      while group_codes.include? new_group_code
        new_group_code = generate_group_code
      end
      return new_group_code
   

    end

  def to_param
    group_code
  end
    
    
    # Generates a random string from a set of easily readable characters
      def self.generate_group_code(size = 6)
        charset = %w{ 2 3 4 6 7 9 A C D E F G H J K M N P Q R T V W X Y Z}
        (0...size).map{ charset.to_a[rand(charset.size)] }.join
      end


end
