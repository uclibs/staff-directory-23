# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: 'lisa.haitz@uc.edu'
  layout 'mailer'
end
