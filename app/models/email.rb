#
class Email
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  def initialize(email)
    @email = email
  end
  
  def validate
    format = check_format?
    if format
      present = check_present?
    end
    return format && present
  end
  
  def check_format?
    if @email.match(VALID_EMAIL_REGEX)
      true
    else
      false
    end
  end
  
  def check_email?
    if User.find_by(:email).present?
      true
    else
      false
    end
  end
end