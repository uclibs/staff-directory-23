# frozen_string_literal: true

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!, except: %i[index show]
  rescue_from ActiveRecord::InvalidForeignKey, with: :rescue_from_invalid_foreign_key

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[email password])
  end

  def rescue_from_invalid_foreign_key
    flash[:error] = 'Cannot delete department with associated employees.'
    redirect_to departments_path
  end
end
