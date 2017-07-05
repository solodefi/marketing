class Users::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  include RedirectLanding
  def create
    #   user = User.find_by_email(params[:email])
    #   puts "creating session of" 
    #   puts params[:email]
    #   if(user)
    #       puts "user is available"
    #   else
    #     puts "user is not available"
    #   end
    #   if user && user.authenticate(params[:password])
    #     if user.email_confirmed
    #         super
    # #    redirect_to path_to_redirect
    #     else
    #       puts "**********************************************************"
    #       puts user.email+"is available but it's not registered yet!"
    #       flash.now[:error] = 'Please activate your account by following the 
    #       instructions in the account confirmation email you received to proceed'
    #       redirect_to homepage_index_url
    #     end
    #   else
    #     puts "**********************************************************"
    #     puts "Invalid email/password combination"
    #     flash.now[:error] = 'Invalid email/password combination' # Not quite right!
    #     redirect_to homepage_index_url
    #   end
    super
  end
  protected

  def after_sign_in_path_for(resource)
    path_to_redirect
  end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
  
end
