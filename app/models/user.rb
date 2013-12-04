#
class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  # devise :database_authenticatable, :registerable,
         # :recoverable, :rememberable, :trackable, :validatable
         
  # devise  :recoverable
  before_create :set_jabber_id
  
  validates :name, presence: true, length: { maximum: 50 },
                   uniqueness: { case_sensitive: false }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  has_many :groups
  has_secure_password validations: false # This is the key to the solution
  has_many :created_groups, class_name: 'Group'
  acts_as_follower

  def send_password_reset
    generate_token(:password_reset_token)
    self.password_reset_sent_at = Time.zone.now
    save!
    UserMailer.password_reset(self).deliver
  end

  def generate_token(column)
    loop do
      self[column] = SecureRandom.urlsafe_base64
      break unless User.exists?(column => self[column])
    end
  end

  def self.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def self.encrypt(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

  def self.members_without_trailing_(jabber_ids)
    return nil if jabber_ids.nil?
    members = jabber_ids
    members.map do |member|
      index = member.index('/')
      if !index.nil?
        member.slice(0..index - 1)
      else
        member
      end
    end
  end

  def self.get_devices(jabber_ids)
    members = User.members_without_trailing_(jabber_ids)
    if members
      users = User.where(jabber_id: members)
      users.map do |user|
        user.device_identifier
      end
    end
  end

  def set_jabber_id
    self.jabber_id = "#{name}@idlecampus.com"
  end

  def to_hash
    attacher = {}
    attacher[:name] = name
    attacher[:password] = password
  end

  private

    def create_remember_token
      self.remember_token = User.encrypt(User.new_remember_token)
    end
end
