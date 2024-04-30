# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: ENV.fetch('STADIR_MAILER_FROM', 'localhost').presence || 'localhost'
  layout 'mailer'
end
