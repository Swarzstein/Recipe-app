class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  protect_from_forgery with: :exception
  before_action :update_allowed_parameters, if: :devise_controller?

  def current_ability
    @current_ability ||= Ability.new(current_user)
  end

  def after_sign_in_path_for(_resource)
    users_path
  end

  def after_sign_out_path_for(_resource)
    sign_out_current_user
    root_path
  end

  protected

  def update_allowed_parameters
    devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:name, :email, :password) }
    devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:name, :email, :password, :current_password) }
  end

  def sign_out_current_user
    cookies.delete(:_session_id)
  end

  def set_current_user
    @current_user = current_user
  end
end
