class ApplicationController < ActionController::Base
  rescue_from ActiveRecord::InvalidForeignKey, with: :handle_invalid_foreign_key

  protected

  def handle_invalid_foreign_key
    flash[:error] = "Cannot delete department with associated employees."
    redirect_to departments_path
  end

  def config_devise_params
    devise_parameter_sanitizer.permit(:sign_in, keys: [
      :first_name,
      :last_name,
      :username,
      :email,
      :password,
      :password_confirmation
    ])
  end

  def index
    @employees = Employee.all
    #added below for devise
    layout :layout_by_resource
  end

  private

  def layout_by_resource
    devise_controller? ? "session" : "application"
  end
end
