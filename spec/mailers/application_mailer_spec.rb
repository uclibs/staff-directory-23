# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ApplicationMailer, type: :mailer do
  describe 'password_change' do
    let(:user) { create(:user) }

    it 'renders the subject' do
      mail = described_class.password_change(user)
      expect(mail.subject).to eq('Your password has been changed')
    end

    it 'renders the body' do
      mail = described_class.password_change(user)
      expect(mail.body.encoded).to include('Your password has been successfully changed.')
    end
  end

  # More test cases for other mailer methods/views
end
