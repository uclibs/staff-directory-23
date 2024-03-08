# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PasswordsController, type: :controller do
  include Devise::Test::ControllerHelpers # Include this if you haven't globally

  before do
    @request.env['devise.mapping'] = Devise.mappings[:user]
  end

  describe 'POST #create' do
    let(:user) { FactoryBot.create(:user) } # Assuming you have a factory for users

    context 'with valid email' do
      it 'sends reset password instructions and redirects to root with a success message' do
        post :create, params: { user: { email: user.email } }

        expect(response).to redirect_to(root_path)
        expect(flash[:notice]).to eq('Reset password instructions have been sent to your email! Very exciting!')
      end
    end

    context 'with invalid email' do
      it 'renders the new template with an error message' do
        post :create, params: { user: { email: 'nonexistent@example.com' } }

        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.body).to include('Invalid email')
      end
    end
  end
end
