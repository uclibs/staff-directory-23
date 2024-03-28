# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: ENV['STADIR_MAILER_FROM']
  layout 'mailer'
end
