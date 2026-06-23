# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Shibboleth authentication', type: :request do
  describe ShibbolethSessionsController do
    before do
      allow(ShibbolethLogin).to receive(:enabled?).and_return(true)
    end

    it 'signs in a user with a matching eppn' do
      create(:user, email: 'bearcat@uc.edu', eppn: 'bearcat@uc.edu')

      get shibboleth_login_path, headers: { 'HTTP_EPPN' => 'bearcat@uc.edu' }

      expect(response).to redirect_to(employees_path)
      expect(flash[:notice]).to eq('Signed in successfully.')

      follow_redirect!
      get new_employee_path

      expect(response).to have_http_status(:ok)
    end

    it 'signs in when the IdP eppn casing differs from the stored value' do
      create(:user, email: 'bearcat@uc.edu', eppn: 'bearcat@uc.edu')

      get shibboleth_login_path, headers: { 'HTTP_EPPN' => 'Bearcat@UC.edu' }

      expect(response).to redirect_to(employees_path)
    end

    it 'denies access when eppn is missing' do
      get shibboleth_login_path

      expect(response).to redirect_to(root_path)
      expect(flash[:alert]).to eq('Shibboleth authentication did not provide an eppn.')
    end

    it 'denies access when no user matches the eppn' do
      get shibboleth_login_path, headers: { 'HTTP_EPPN' => 'unknown@uc.edu' }

      expect(response).to redirect_to(root_path)
      expect(flash[:alert]).to eq('You are not authorized to access staff tools.')
    end

    it 'redirects to password login when Shibboleth is disabled' do
      allow(ShibbolethLogin).to receive(:enabled?).and_return(false)

      get shibboleth_login_path, headers: { 'HTTP_EPPN' => 'bearcat@uc.edu' }

      expect(response).to redirect_to(new_user_session_path)
      expect(flash[:alert]).to eq('Password login is enabled in this environment.')
    end
  end

  describe SessionsController do
    let(:user) { create(:user, email: 'staff@uc.edu', password: 'password') }

    it 'redirects to Shibboleth login when enabled' do
      allow(ShibbolethLogin).to receive(:enabled?).and_return(true)

      get new_user_session_path

      expect(response).to redirect_to(shibboleth_login_path)
    end

    it 'blocks password sign-in when Shibboleth is enabled' do
      allow(ShibbolethLogin).to receive(:enabled?).and_return(true)

      post user_session_path, params: { user: { email: user.email, password: 'password' } }

      expect(response).to redirect_to(shibboleth_login_path)
      expect(flash[:alert]).to eq('Please sign in with Shibboleth.')
    end

    it 'shows the password form when Shibboleth is disabled' do
      allow(ShibbolethLogin).to receive(:enabled?).and_return(false)

      get new_user_session_path

      expect(response).to have_http_status(:ok)
      expect(response.body).to include('Log in')
    end

    it 'allows logout when Shibboleth is enabled' do
      sign_in user
      allow(ShibbolethLogin).to receive(:enabled?).and_return(true)

      delete destroy_user_session_path

      expect(response).to redirect_to(root_path)

      get new_employee_path

      expect(response).to redirect_to(new_user_session_path)
    end
  end

  describe PasswordsController, type: :request do
    it 'blocks password reset requests when Shibboleth is enabled' do
      allow(ShibbolethLogin).to receive(:enabled?).and_return(true)

      post forgot_password_path, params: { user: { email: 'staff@uc.edu' } }

      expect(response).to redirect_to(root_path)
      expect(flash[:alert]).to eq('Password reset is not available. Please sign in with Shibboleth.')
    end

    it 'allows password reset form access from email tokens when Shibboleth is enabled' do
      user = create(:user, email: 'staff@uc.edu')
      raw_token, hashed_token = Devise.token_generator.generate(User, :reset_password_token)
      user.update!(reset_password_token: hashed_token, reset_password_sent_at: Time.current)
      allow(ShibbolethLogin).to receive(:enabled?).and_return(true)

      get reset_password_path, params: { reset_password_token: raw_token }

      expect(response).to have_http_status(:ok)
      expect(response.body).to include('Change your password')
    end
  end
end
