# frozen_string_literal: true

require 'rails_helper'
require Rails.root.join('lib/seed_helper')

RSpec.describe SeedHelper do
  around do |example|
    original = ENV.fetch('SEED_TEST_USER', nil)
    example.run
  ensure
    if original.nil?
      ENV.delete('SEED_TEST_USER')
    else
      ENV['SEED_TEST_USER'] = original
    end
  end

  def stub_hostname(name)
    allow(Socket).to receive(:gethostname).and_return(name)
  end

  describe '.test_server?' do
    it 'is true when SEED_TEST_USER is set, even on the production host' do
      ENV['SEED_TEST_USER'] = 'true'
      stub_hostname('libapps.libraries.uc.edu')

      expect(described_class.test_server?).to be(true)
    end

    it 'is true for an allowed test-server hostname' do
      stub_hostname('libappstest')

      expect(described_class.test_server?).to be(true)
    end

    it 'is true when the hostname contains libappstest' do
      stub_hostname('libappstest-extra')

      expect(described_class.test_server?).to be(true)
    end

    it 'is false on the production hostname' do
      stub_hostname('libapps.libraries.uc.edu')

      expect(described_class.test_server?).to be(false)
    end
  end

  describe '.seed_test_user!' do
    it 'creates the test user on the test server' do
      stub_hostname('libappstest.libraries.uc.edu')

      described_class.seed_test_user!

      user = User.find_by(email: described_class::TEST_USER_EMAIL)
      expect(user&.valid_password?(described_class::TEST_USER_PASSWORD)).to be(true)
    end

    it 'resets the password when the test user already exists' do
      create(:user, email: described_class::TEST_USER_EMAIL, password: 'old-password')
      stub_hostname('libappstest')

      described_class.seed_test_user!

      user = User.find_by(email: described_class::TEST_USER_EMAIL)
      expect(user.valid_password?(described_class::TEST_USER_PASSWORD)).to be(true)
    end

    it 'does not create the test user on the production server' do
      stub_hostname('libapps.libraries.uc.edu')

      described_class.seed_test_user!

      expect(User.find_by(email: described_class::TEST_USER_EMAIL)).to be_nil
    end

    it 'logs a warning when the test user cannot be saved' do
      stub_hostname('libappstest')
      user = User.new(email: described_class::TEST_USER_EMAIL)
      allow(User).to receive(:find_or_initialize_by).and_return(user)
      allow(user).to receive(:save!).and_raise(ActiveRecord::RecordInvalid.new(user))
      allow(Rails.logger).to receive(:warn)

      described_class.seed_test_user!

      expect(Rails.logger).to have_received(:warn).with(/Could not seed test user/)
    end
  end
end
