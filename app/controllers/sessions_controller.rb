# frozen_string_literal: true

# Redirects server environments to Shibboleth; development and test use password login.
class SessionsController < Devise::SessionsController
  def new
    if ShibbolethLogin.enabled?
      redirect_to shibboleth_login_path
    else
      super
    end
  end
end
