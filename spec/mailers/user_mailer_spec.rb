# spec/mailers/user_mailer_spec.rb
require 'rails_helper'

RSpec.describe UserMailer, type: :mailer do
  describe 'password_change' do
    let(:user) { create(:user) }

    before do
      # Assuming UserMailer has the password_change method implemented
      @mail = UserMailer.password_change(user)
    end

    it 'renders the subject' do
      expect(@mail.subject).to eq('Your password has been changed')
    end

    it 'renders the body' do
      expect(@mail.body.encoded).to include('Your password has been successfully changed.')
    end
  end
end
