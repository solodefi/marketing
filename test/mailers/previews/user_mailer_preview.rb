# Preview all emails at http://localhost:3000/rails/mailers/user_mailer/welcome_preview
# Preview all emails at http://localhost:3000/rails/mailers/user_mailer/confirmation_email_preview
class UserMailerPreview < ActionMailer::Preview
  def welcome_preview
    UserMailer.Welcome_message(User.first)
  end
  def confirmation_email_preview
    UserMailer.registration_confirmation(User.first)
  end
end
