class User < ActiveRecord::Base
  before_save :saved
  def saved
    puts "#{self} saved"
  end
   before_create :set_jabber_id

  validates :name, presence: true, length: { maximum: 50 },presence: true,uniqueness: { case_sensitive: false }
 VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
 has_many :groups
   has_secure_password
   # has_many :groups,through: :group_membership
  # validates :password, length: { minimum: 6 }

 

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
    
    if jabber_ids
      users = User.where(jabber_id:jabber_ids)
      users.map do |user|
        
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