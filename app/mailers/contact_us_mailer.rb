class ContactUsMailer < ActionMailer::Base

  default from: "Structured Thinking <akiradeves@gmail.com>"
  default to: "info@structured-thinking.co.uk"

  def new_message(message)
    @message = message

    mail subject: @message.subject
  end

end