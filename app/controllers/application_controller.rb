# frozen_string_literal: true

# Application Controller
class ApplicationController < ActionController::Base
  include Pundit

  protect_from_forgery with: :exception
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  add_flash_types :success, :warning, :danger, :info

  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!


  private

  def after_sign_in_path_for(_)
    users_path
  end

  def user_not_authorized
    redirect_to current_user, alert: 'you are not authorized'
  end

  def record_not_found
    redirect_to (request.referrer || root_path), alert: 'Record not found'
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) do |u|
      u.permit(:name, :email, :password, :password_confirmation, :username, :mobilenumber, :avatar)
    end

    devise_parameter_sanitizer.permit(:account_update) do |u|
      u.permit(:name, :email, :password, :current_password, :username, :mobilenumber, :avatar)
    end
  end
end
