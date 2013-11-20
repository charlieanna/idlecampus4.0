class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  # devise :database_authenticatable, :registerable,
  #        :recoverable, :rememberable, :trackable, :validatable
  # before_save :saved
 #  def saved
 #    puts "#{self} saved"
 #  end
   before_create :set_jabber_id

  validates :name, presence: true, length: { maximum: 50 },presence: true,uniqueness: { case_sensitive: false }
 VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
 has_many :groups
   has_secure_password
 has_many :created_groups, class_name: 'Group'
 acts_as_follower

def send_password_reset
    generate_token(:password_reset_token)
    self.password_reset_sent_at = Time.zone.now
    save!
    UserMailer.password_reset(self).deliver
  end

  def generate_token(column)
    begin
      self[column] = SecureRandom.urlsafe_base64
    end while User.exists?(column => self[column])
  end

  
   def User.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def User.encrypt(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

   def self.get_devices(jabber_ids)
     members = jabber_ids
     # puts jabber_ids
     members = members.map do |member|
       index = member.index('/')
       unless index.nil?
         member.slice(0..index-1)
       else 
         member
       end
     end
    if members
      users = User.where(jabber_id:members)
      users.map do |user|
        # puts "USER"
 #        puts user.jabber_id
        user.device_identifier
      end
    end
    
    
    
  end

  def set_jabber_id
    
    self.jabber_id = "#{self.name}@idlecampus.com"
    
  end

  def to_hash
    attacher = {}
    attacher[:name] = self.name
      
    attacher[:password] = self.password
    return attacher
  end

  private

    def create_remember_token
      self.remember_token = User.encrypt(User.new_remember_token)
    end
end