# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Shibboleth authentication', type: :request do
  describe ShibbolethSessionsController do
    before do
      allow(ShibbolethLogin).to receive(:enabled?).and_return(true)
    end

    it 'signs in a user with a matching eppn' do
      user = create(:user, email: 'bearcat@uc.edu', eppn: 'bearcat@uc.edu')

      get shibboleth_login_path, headers: { 'HTTP_EPPN' => 'bearcat@uc.edu' }

      expect(response).to redirect_to(employees_path)
      expect(flash[:notice]).to eq('Signed in successfully.')
      expect(session['warden.user.user.key']).to eq([[user.id], user.encrypted_password[0, 29]])
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
  end

  describe SessionsController do
    it 'redirects to Shibboleth login when enabled' do
      allow(ShibbolethLogin).to receive(:enabled?).and_return(true)

      get new_user_session_path

      expect(response).to redirect_to(shibboleth_login_path)
    end

    it 'shows the password form when Shibboleth is disabled' do
      allow(ShibbolethLogin).to receive(:enabled?).and_return(false)

      get new_user_session_path

      expect(response).to have_http_status(:ok)
      expect(response.body).to include('Log in')
    end
  end
end
