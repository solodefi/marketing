class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?

  protected
  
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit({ roles: [] }, :title, :first_name, :last_name, :location_id, :email, :password, :password_confirmation, :image, :user_type, :postcode) }
    devise_parameter_sanitizer.permit(:account_update) { |u| u.permit({ roles: [] }, :title, :first_name, :last_name, :country, :email, :password, :password_confirmation, :image, :user_type, :postcode) }
  end
end