class AboutController < ApplicationController

  def index

  end

  def how_it_works

  end

  def privacy_policy
    
  end

  def contact_us
    @message = ContactUsMessage.new
  end
  def invite_friends
    @message = InviteFriendsMessage.new
  end

  def send_contact_us_message
    @message = ContactUsMessage.new(contact_us_message_params)

    if @message.valid?
      ContactUsMailer.new_message(@message).deliver
      flash[:notice] = "Your message has been sent. We will contact you soon."
      redirect_to contact_us_about_index_path
    else
      flash[:alert] = "An error occurred while delivering this message."
      render :contact_us
    end
  end

  def send_invite_friends_message
    @message = InviteFriendsMessage.new(invite_friends_message_params)

    if @message.valid?
      InviteFriendsMailer.new_message(@message,current_user).deliver
      flash[:notice] = "Your message has been sent. We will contact you soon."
      redirect_to invite_friends_about_index_path
    else
      flash[:alert] = "An error occurred while delivering this message."
      render :invite_friends
    end
  end

  private
    def invite_friends_message_params
      params.require(:invite_friends_message).permit(:email, :content)
    end
    def contact_us_message_params
      params.require(:contact_us_message).permit(:name, :email, :content, :subject)
    end

end
