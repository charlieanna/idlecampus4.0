#
class Group < ActiveRecord::Base
  has_many :folders
  validates :name, presence: true
  has_one :timetable
  has_many :timetable_fields
  belongs_to :user
  has_many :teachers
  has_many :subjects
  has_many :rooms
  has_many :alerts, :order => 'created_at desc'
  has_many :notes
  has_many :files, through: :notes
  has_many :students
  belongs_to :teacher
  has_many :followers, class_name: 'Student'
  belongs_to :creator, class_name: 'Teacher', foreign_key: 'teacher_id'
  acts_as_followable
  
  before_create :set_group_code
  
  def set_group_code
   self.group_code = Group.get_group_code
  end

  def get_users
    res = []
    
    members = self.followers
    members = members.map do |member|
      index = member.jabber_id.index('/')
      if !index.nil?
        member.jabber_id.slice(0..index - 1)
      else
        member.jabber_id
      end
      
    end
    return members
  end

  def self.get_group_code
    new_group_code = generate_group_code
    while Group.exists?(group_code: new_group_code)
      new_group_code = generate_group_code
    end
    new_group_code
  end

  # def to_param
  #   group_code
  # end

  # Generates a random string from a set of easily readable characters
  def self.generate_group_code(size = 6)
    charset = %w{ 2 3 4 6 7 9 A C D E F G H J K M N P Q R T V W X Y Z}
    (0...size).map { charset.to_a[rand(charset.size)] }.join
  end

  def to_hash
    group = {}
    group[:name] = name
    group[:code] = group_code
    group
  end
end
