# frozen_string_literal: true

class PasswordsController < Devise::PasswordsController
  # POST /resource/password
  def create
    self.resource = resource_class.send_reset_password_instructions(resource_params)
    if successfully_sent?(resource)
      # render json: { message: 'Reset password instructions sent' }, status: :ok
      # render 'devise/mailer/reset_password_instructions_sent' # Render HTML view
    else
      render json: { error: 'Invalid email' }, status: :unprocessable_entity
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
      # render json: { message: 'Password successfully updated' }, status: :ok
    else
      # Handle errors while updating the password
      render json: { error: resource.errors.full_messages.join(', ') }, status: :unprocessable_entity

    end
  end
end
