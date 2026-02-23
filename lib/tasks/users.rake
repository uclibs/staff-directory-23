# frozen_string_literal: true

namespace :users do
  desc 'Create or reset the test user (test@example.com) on the test server only (libappstest). Safe to run on production — no-op there.'
  task seed_test_user: :environment do
    require Rails.root.join('lib/seed_helper')
    if SeedHelper.test_server?
      SeedHelper.seed_test_user!
      puts "Test user #{SeedHelper::TEST_USER_EMAIL} created/updated."
    else
      puts "Skipped (not test server). Hostname: #{Socket.gethostname}"
    end
  end

  desc 'Create or update any user (any email/password you pass). Usage: EMAIL=someone@uc.edu PASSWORD=yourpassword rails users:create'
  task create: :environment do
    email = ENV['EMAIL'].to_s.strip
    password = ENV['PASSWORD'].to_s

    if email.blank? || password.blank?
      puts 'Usage: EMAIL=someone@uc.edu PASSWORD=yourpassword rails users:create'
      exit 1
    end

    user = User.find_or_initialize_by(email: email)
    user.password = password
    user.password_confirmation = password
    if user.save
      puts "User #{email} created/updated."
    else
      puts "Error: #{user.errors.full_messages.join(', ')}"
      exit 1
    end
  end
end
