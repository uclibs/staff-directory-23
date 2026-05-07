# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UserMailer do
  describe 'password_change' do
    let(:user) { create(:user) }
    let(:mail) { described_class.password_change(user) }

    it 'renders the subject' do
      expect(mail.subject).to eq('Your password has been changed')
    end

    it 'renders the body' do
      expect(mail.body.encoded).to include('Your password has been successfully changed.')
    end
  end
end
