# frozen_string_literal: true

# Shibboleth login is enabled on libapps/libappstest via Apache and STADIR_USE_SHIBBOLETH.
# Development and test keep Devise password login.
module ShibbolethLogin
  module_function

  def enabled?
    ENV['STADIR_USE_SHIBBOLETH'] == 'true'
  end

  def eppn_from(request)
    request.env['HTTP_EPPN'].presence || request.env['HTTP_eppn'].presence
  end
end
