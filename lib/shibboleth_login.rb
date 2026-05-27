# frozen_string_literal: true

# Shibboleth login is enabled in production (libapps/libappstest via Apache).
# Development and test keep Devise password login.
module ShibbolethLogin
  module_function

  def enabled?
    Rails.env.production?
  end

  def normalize_eppn(value)
    value.to_s.strip.downcase.presence
  end

  def eppn_from(request)
    raw_eppn = request.env['HTTP_EPPN'].presence || request.env['HTTP_eppn'].presence
    normalize_eppn(raw_eppn)
  end
end
