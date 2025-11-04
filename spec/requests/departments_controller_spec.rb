# frozen_string_literal: true

require 'rails_helper'
RSpec.describe 'Departments' do
  # Testing the `index` action:
  before do
    user = create(:user)
    sign_in user
  end

  describe 'GET /index' do
    it 'returns a successful response and displays departments' do
      department = create(:department)
      get departments_path
      expect(response).to have_http_status(:success)
      expect(response.body).to include(department.name)
    end
  end

  # Testing the `show` action:
  describe 'GET /show' do
    it 'returns a successful response and displays department details' do
      department = create(:department)
      get department_path(department)
      expect(response).to have_http_status(:success)
      expect(response.body).to include(department.name)
    end
  end

  # Testing the `new` action:
  describe 'GET /new' do
    it 'returns a successful response' do
      get new_department_path
      expect(response).to have_http_status(:success)
    end
  end

  # Testing the `create` action:
  describe 'POST /create' do
    it 'creates a new department and redirects' do
      department_attributes = attributes_for(:department)
      expect do
        post departments_path, params: { department: department_attributes }
      end.to change(Department, :count).by(1)
      expect(response).to redirect_to departments_path
      follow_redirect!
      expect(response.body).to include(department_attributes[:name])
    end
  end

  # Testing the `edit` action:
  describe 'GET /edit' do
    it 'returns a successful response' do
      department = create(:department)
      get edit_department_path(department)
      expect(response).to have_http_status(:success)
    end
  end

  # Testing the `update` action:
  describe 'PUT /update' do
    let(:department) { create(:department) }
    let(:updated_name) { 'Updated Department Name' }

    it 'updates the department and redirects' do
      put department_path(department), params: { department: { name: updated_name } }
      expect(response).to redirect_to department_path(department)
      follow_redirect!
      expect(response.body).to include(updated_name)
    end
  end

  # Testing the `destroy` action:
  describe 'DELETE /destroy' do
    it 'deletes a department and redirects' do
      department = create(:department)
      expect do
        delete department_path(department)
      end.to change(Department, :count).by(-1)
      expect(response).to redirect_to departments_path
    end
  end
end
