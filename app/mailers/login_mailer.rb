class LoginMailer < ApplicationMailer
  def welcome_email(user)
    @user = user
    @url = "https://example.com/login"
    mail(to: user.email, from: "Login Code <lisa.haitz@uc.edu>", subject: "Your Login Code")
  end
end