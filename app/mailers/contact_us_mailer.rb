class ContactUsMailer < ApplicationMailer

  

  def new_message(message)
    @message = message
    mail subject: @message.subject
  end

end