# app/mailers/user_mailer.rb
class UserMailer < ApplicationMailer
  # Method to send password change email
  def password_change(user)
    @user = user
    mail(to: @user.email, subject: 'Your password has been changed')
  end
end
