class Group < ActiveRecord::Base
  has_many :folders
	validates :name,presence: true
    has_one :timetable
    has_many :timetable_fields
    belongs_to :user
    has_many :teachers
    has_many :subjects
    has_many :rooms
    has_many :alerts
    has_many :notes
    has_many :students
    belongs_to :teacher
    has_many :followers,class_name: 'Student'
    belongs_to :creator, class_name: 'Teacher',:foreign_key => 'teacher_id'
    acts_as_followable
  def get_users
    xmpp = DRbObject.new_with_uri "druby://localhost:7777"
     
    subscriptions = xmpp.get_subscriptions_from(self.group_code)
    
    res = []
         subscriptions.each { |sub|
              res << sub.jid.to_s
            }
            
            puts "MEMBERSSSSSS"
          puts res
    
    members = res
     
    puts "subscriptions: #{members}\n\n"
    
    
    
    if members
      members = User.members_without_trailing_(members)
     
    end
    return members
  end
    
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


      def to_hash
        group = {}
        group[:name] = self.name
        group[:code] = self.group_code
        group
      end

      

end
