# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: ENV.fetch('STADIR_PRODUCTION_MAILER_FROM', 'localhost').presence || 'localhost'
  layout 'mailer'
end
