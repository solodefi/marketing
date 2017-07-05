class Users::ConfirmationsController < Devise::ConfirmationsController
  include RedirectLanding
  # GET /resource/confirmation/new
  # def new
  #   super
  # end

  # POST /resource/confirmation
  # def create
  #   super
  # end

  # GET /resource/confirmation?confirmation_token=abcdef
  # def show
  #   super
  # end

  # protected

  # The path used after resending confirmation instructions.
  # def after_resending_confirmation_instructions_path_for(resource_name)
  #   super(resource_name)
  # end

  # The path used after confirmation.
  # def after_confirmation_path_for(resource_name, resource)
  #   super(resource_name, resource)
  # end

  def confirm_email
    user = User.find_by_confirm_token(params[:confirm_token])
    if user
      user.email_confirmed = true 
      user.save
      UserMailer.Welcome_message(user).deliver
      flash[:success] = "Welcome to the Sample App! Your email has been confirmed.
      Please sign in to continue."
      puts "**********************************************************"
      puts user.email
      redirect_to path_to_redirectparam1(user)
    else
      puts "**********************************************************"
      puts "no user is available!!"
      flash[:error] = "Sorry. User does not exist"
      redirect_to homepage_index_url
    end
  end

  def confirm_email_params
    params.permit(:confirm_token)
  end
end
