# frozen_string_literal: true

# Redirects server environments to Shibboleth; development and test use password login.
class SessionsController < Devise::SessionsController
  before_action :redirect_to_shibboleth_login, if: -> { ShibbolethLogin.enabled? }, only: %i[new create]

  private

  def redirect_to_shibboleth_login
    redirect_to shibboleth_login_path, alert: 'Please sign in with Shibboleth.'
  end
end
