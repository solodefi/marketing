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

  def send_contact_us_message
    @message = ContactUsMessage.new(message_params)

    if @message.valid?
      ContactUsMailer.new_message(@message).deliver
      flash[:notice] = "Your message has been sent. We will contact you soon."
      redirect_to contact_us_about_index_path
    else
      flash[:alert] = "An error occurred while delivering this message."
      render :contact_us
    end
  end

  private

    def message_params
      params.require(:contact_us_message).permit(:name, :email, :content, :subject)
    end

end
