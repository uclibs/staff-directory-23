# frozen_string_literal: true

# Establishes a Devise session from the Shibboleth eppn Apache passes through.
class ShibbolethSessionsController < ApplicationController
  skip_before_action :authenticate_user!

  def create
    unless ShibbolethLogin.enabled?
      redirect_to new_user_session_path, alert: 'Password login is enabled in this environment.'
      return
    end

    eppn = ShibbolethLogin.eppn_from(request)
    if eppn.blank?
      redirect_to root_path, alert: 'Shibboleth authentication did not provide an eppn.'
      return
    end

    user = User.find_by(eppn: eppn)
    if user.nil?
      redirect_to root_path, alert: 'You are not authorized to access staff tools.'
      return
    end

    sign_in(user)
    redirect_to employees_path, notice: 'Signed in successfully.'
  end
end
