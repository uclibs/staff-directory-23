# frozen_string_literal: true

class PasswordsController < Devise::PasswordsController
  # POST /resource/password
  def create
    self.resource = resource_class.send_reset_password_instructions(resource_params)
    if successfully_sent?(resource)
      flash[:notice] = 'Reset password instructions have been sent to your email! Very exciting!'
      respond_with({}, location: after_sending_reset_password_instructions_path_for(resource_name))
    else
      # Instead of rendering a JSON response, render an HTML view for the error
      flash.now[:alert] = 'Invalid email' # Optional: Use flash.now to show the error message on the rendered view
      render 'invalid_email', status: :unprocessable_entity
    end
  end

  # GET /resource/password/edit?reset_password_token=abcdef
  def edit
    self.resource = resource_class.new
    resource.reset_password_token = params[:reset_password_token]
  end

  def update
    self.resource = resource_class.reset_password_by_token(resource_params)
    if resource.errors.empty?
      # Password has been successfully updated
      sign_in(resource_name, resource)
      render 'password_change' # Render HTML view
    else
      # Handle errors while updating the password
      render json: { error: resource.errors.full_messages.join(', ') }, status: :unprocessable_entity
    end
  end

  protected

  # Override this Devise method to customize the redirection path after sending reset password instructions
  def after_sending_reset_password_instructions_path_for(_resource_name)
    # Redirects to the root path of the application
    root_path
  end
end
