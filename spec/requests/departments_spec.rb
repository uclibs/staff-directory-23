# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Departments' do
  include Devise::Test::IntegrationHelpers # Include Devise test helpers
  describe 'GET /departments' do
    it 'redirects to sign-in page when user is not logged in' do
      get departments_path
      expect(response).to redirect_to(new_user_session_path)
    end

    it 'displays the departments index when user is logged in' do
      user = create(:user)
      sign_in user

      get departments_path
      expect(response).to be_successful
      expect(response).to render_template(:index)
    end
  end

  describe 'GET /departments/:id' do
    it 'redirects to sign-in page when user is not logged in' do
      department = create(:department)

      get department_path(department)
      expect(response).to redirect_to(new_user_session_path)
    end

    it 'displays the department when user is logged in' do
      user = create(:user)
      department = create(:department)
      sign_in user

      get department_path(department)
      expect(response).to be_successful
      expect(response).to render_template(:show)
    end
  end

  describe 'GET /departments/new' do
    it 'redirects to sign-in page when user is not logged in' do
      get new_department_path
      expect(response).to redirect_to(new_user_session_path)
    end

    it 'displays the new department form when user is logged in' do
      user = create(:user)
      sign_in user

      get new_department_path
      expect(response).to be_successful
      expect(response).to render_template(:new)
    end
  end

  describe 'POST /departments' do
    it 'redirects to sign-in page when user is not logged in' do
      post departments_path, params: { department: { name: 'Test Department' } }
      expect(response).to redirect_to(new_user_session_path)
    end

    it 'creates a new department when user is logged in with valid parameters' do
      user = create(:user)
      sign_in user

      expect do
        post departments_path, params: { department: { name: 'Test Department' } }
      end.to change(Department, :count).by(1)

      expect(response).to redirect_to(departments_path)
    end

    it 'renders the new department form when user is logged in with invalid parameters' do
      user = create(:user)
      sign_in user

      expect do
        post departments_path, params: { department: { name: '' } }
      end.not_to change(Department, :count)

      expect(response).to be_successful
      expect(response).to render_template(:new)
    end
  end

  describe 'GET /departments/:id/edit' do
    it 'redirects to sign-in page when user is not logged in' do
      department = create(:department)

      get edit_department_path(department)
      expect(response).to redirect_to(new_user_session_path)
    end

    it 'displays the edit department form when user is logged in' do
      user = create(:user)
      department = create(:department)
      sign_in user

      get edit_department_path(department)
      expect(response).to be_successful
      expect(response).to render_template(:edit)
    end
  end

  describe 'PATCH /departments/:id' do
    it 'redirects to sign-in page when user is not logged in' do
      department = create(:department)

      patch department_path(department), params: { department: { name: 'Updated Department' } }
      expect(response).to redirect_to(new_user_session_path)
    end

    it 'updates the department when user is logged in with valid parameters' do
      user = create(:user)
      department = create(:department)
      sign_in user

      patch department_path(department), params: { department: { name: 'Updated Department' } }
      expect(response).to redirect_to(department_path(department))

      department.reload
      expect(department.name).to eq('Updated Department')
    end

    it 'renders the edit department form when user is logged in with invalid parameters' do
      user = create(:user)
      department = create(:department)
      sign_in user

      patch department_path(department), params: { department: { name: '' } }
      expect(response).to be_successful
      expect(response).to render_template(:edit)
    end
  end

  describe 'DELETE /departments/:id' do
    it 'redirects to sign-in page when user is not logged in' do
      department = create(:department)

      delete department_path(department)
      expect(response).to redirect_to(new_user_session_path)
    end

    it 'deletes the department when user is logged in' do
      user = create(:user)
      department = create(:department)
      sign_in user

      expect do
        delete department_path(department)
      end.to change(Department, :count).by(-1)

      expect(response).to redirect_to(departments_path)
    end
  end
end
