class User < ActiveRecord::Base
 #  before_save { email.downcase! }
 #  before_create :create_remember_token
 #  validates :jabber_id, presence: true, length: { maximum: 50 }
 # VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
 #  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX },
 #                    uniqueness: { case_sensitive: false }
 has_many :groups
   has_secure_password
   # has_many :groups,through: :group_membership
  # validates :password, length: { minimum: 6 }


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

  private

    def create_remember_token
      self.remember_token = User.encrypt(User.new_remember_token)
    end
end