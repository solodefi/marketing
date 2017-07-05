class InviteFriendsMailer < ApplicationMailer

  

  def new_message(message, user)
    @message = message
    @user = user
    mail to:@message.email, subject: "Invitation"
  end

end