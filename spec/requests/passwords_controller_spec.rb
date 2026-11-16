# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PasswordsController, type: :controller do
  include Devise::Test::ControllerHelpers # Include this if you haven't globally

  before do
    request.env['devise.mapping'] = Devise.mappings[:user]
  end

  describe 'POST #create' do
    let(:user) { create(:user) } # Assuming you have a factory for users

    context 'with valid email' do
      it 'sends reset password instructions and redirects to instructions_sent with a success message' do
        post :create, params: { user: { email: user.email } }

        expect(response).to redirect_to(instructions_sent_path)
        expect(flash[:notice]).to eq('Reset password instructions have been sent to your email! Very exciting!')
      end
    end

    context 'with invalid email' do
      it 'renders the invalid_email template with an error message' do
        post :create, params: { user: { email: 'nonexistent@example.com' } } # Use an email that does not exist in your test DB

        expect(response).to have_http_status(:unprocessable_content)
        expect(flash[:alert]).to match('Invalid email')
        expect(response).to render_template('invalid_email')
      end
    end
  end

  describe 'PUT #update' do
    let(:user) { create(:user) }

    def reset_token_for(user)
      raw, hashed = Devise.token_generator.generate(User, :reset_password_token)
      user.update!(reset_password_token: hashed, reset_password_sent_at: Time.current)
      raw
    end

    it 'signs in and renders the success page when the token and password are valid' do
      token = reset_token_for(user)

      put :update, params: {
        user: { reset_password_token: token, password: 'new-password', password_confirmation: 'new-password' }
      }

      expect(response).to render_template('password_change')
      expect(user.reload.valid_password?('new-password')).to be(true)
    end

    it 'renders the error page when the new password is invalid' do
      token = reset_token_for(user)

      put :update, params: {
        user: { reset_password_token: token, password: 'new-password', password_confirmation: 'different' }
      }

      expect(response).to render_template('password_create_error')
      expect(user.reload.valid_password?('new-password')).to be(false)
    end
  end
end
