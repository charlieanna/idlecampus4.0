class Message

  include ActiveModel::Model
   attr_accessor :name, :email, :content
  validates_presence_of :name
 VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }
                    
  validates_length_of :content, :maximum => 500

end