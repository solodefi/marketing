#verification insert
class UserMailer < ApplicationMailer

  def registration_confirmation(user)
    @user = user
    mail to:@user.email, subject: "Registration Confirmation"
  end
  def Welcome_message(user)
    @user = user
    mail to:@user.email, subject: "Welcome to structured thinking"
  end
end
#verification insert end