class NotificationsMailer < ActionMailer::Base

  default :from => "noreply@idlecampus.com"
  default :to => "ankothari@gmail.com"

  def new_message(message)
    @message = message
    mail(:subject => "idlecampus.com #{message.subject}")
  end

end