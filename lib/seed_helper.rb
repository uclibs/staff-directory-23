# frozen_string_literal: true

require 'socket'

# Helpers for db/seed and rake tasks. Ensures test user exists only on test server.
module SeedHelper
  TEST_USER_EMAIL = 'test@example.com'
  TEST_USER_PASSWORD = 'password'

  # Hostnames that are allowed to have the seeded test user (test server only).
  TEST_SERVER_HOSTNAMES = [
    'libappstest.libraries.uc.edu',
    'libappstest'
  ].freeze

  class << self
    # Returns true only when running on the test server (or SEED_TEST_USER=true).
    # Never true on production (libapps.libraries.uc.edu).
    def test_server?
      return true if ENV['SEED_TEST_USER'] == 'true'

      host = Socket.gethostname
      TEST_SERVER_HOSTNAMES.include?(host) || host.include?('libappstest')
    end

    # Creates or resets the test user (test@example.com) only when test_server? is true.
    # Idempotent: safe to run multiple times.
    def seed_test_user!
      return unless test_server?

      user = User.find_or_initialize_by(email: TEST_USER_EMAIL)
      user.password = TEST_USER_PASSWORD
      user.password_confirmation = TEST_USER_PASSWORD
      user.save!
      Rails.logger.info "[SeedHelper] Test user #{TEST_USER_EMAIL} created/updated (test server only)."
    rescue ActiveRecord::RecordInvalid => e
      Rails.logger.warn "[SeedHelper] Could not seed test user: #{e.message}"
    end
  end
end
