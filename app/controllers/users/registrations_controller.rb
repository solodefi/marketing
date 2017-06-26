class Users::RegistrationsController < Devise::RegistrationsController
  # before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]
  include RedirectLanding
  # GET /resource/sign_up
  # def new
  #   super
  # end

  # POST /resource
  def create
    super
    resource.image.recreate_versions! if resource.image?
  end

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  def update
    resource.update_without_password(user_params)
    resource.image.recreate_versions! if resource.image?

    redirect_to path_to_redirect

  end

  # Settings - Email/Password Update
  def settings
    @user = current_user
  end

  # PUT, update user settings
  def update_settings
    @user = current_user
    @user.update_with_password(update_password_params)

    redirect_to path_to_redirect
  end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  # Show Fill Profile Form for freelancer
  def fill_profile
    @user = current_user
  end

  # Update the profile and redirect to freelancer's home page
  def update_profile_after_sign_up
    @user = current_user
    @user.update_without_password(user_params)

    redirect_to browse_jobs_url
  end

  protected
  
  # The path used after sign up.
  def after_sign_up_path_for(resource)
    if current_user.user_type == "Client"
      return path_to_redirect
    elsif current_user.user_type == "Freelancer"
      return fill_profile_url
    end
  end



  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_up_params
  #   devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute])
  # end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end

  def user_params
    params.require(:user).permit({ roles: [] }, :title, :first_name, :last_name, :location_id, :email, :password, :password_confirmation, :image, :user_type, :postcode, :overview, :zoom_w, :zoom_h, :zoom_x, :zoom_y, :drag_x, :drag_y, :profession_id, :rotation_angle, :crop_x, :crop_y, :crop_w, :crop_h, skills: [] )
  end

  def update_password_params
    params.require(:user).permit(:password, :password_confirmation, :current_password)
  end
end
