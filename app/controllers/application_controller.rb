# frozen_string_literal: true

class ApplicationController < ActionController::Base
  # Rails 7 has CSRF on by default (no need to call protect_from_forgery manually)

  # Devise: only require auth on non-Devise controllers
  before_action :authenticate_user!, unless: :devise_controller?
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    extra = %i[firstname lastname phone title department_id]
    devise_parameter_sanitizer.permit(:sign_up,        keys: extra)
    devise_parameter_sanitizer.permit(:account_update, keys: extra)
  end
end
