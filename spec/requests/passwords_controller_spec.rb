# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PasswordsController, type: :request do
  describe 'POST /users/password' do
    let(:user) { create(:user) }

    context 'with valid email' do
      it 'sends reset password instructions' do
        post user_password_path, params: { user: { email: user.email } }
        expect(response).to have_http_status(:ok)
        # Expectation to check if the response renders the correct view or contains the correct message
      end
    end

    context 'with invalid email' do
      it 'returns an error' do
        post user_password_path, params: { user: { email: 'nonexistent@example.com' } }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(JSON.parse(response.body)['error']).to eq('Invalid email')
      end
    end
  end

  # Further tests for `edit` and `update` actions here...
end
