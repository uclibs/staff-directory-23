# frozen_string_literal: true

# spec/mailers/previews/user_mailer_preview.rb

class UserMailerPreview < ActionMailer::Preview
  # Preview this email at http://localhost:3000/rails/mailers/user_mailer/password_change
  def password_change
    # Fetch a user or create a mock user object
    user = User.first || User.new(email: 'user@example.com', name: 'Sample User')
    # Call the mailer method and pass the user object
    UserMailer.password_change(user)
  end
end
