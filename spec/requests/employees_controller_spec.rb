# frozen_string_literal: true
require 'rails_helper'

RSpec.describe 'Employees', type: :request do

  # Set up user authentication before each test
  before do
    @user = create(:user)
    sign_in @user
  end

  describe 'GET /index' do
    it 'returns a successful response and displays employees' do
      employee = create(:employee)
      get employees_path
      expect(response).to have_http_status(:success)
      expect(response.body).to include(employee.firstname) # assuming 'firstname' is an attribute of employee
    end
  end

  describe 'GET /show' do
    it 'returns a successful response and displays employee details' do
      employee = create(:employee)
      get employee_path(employee)
      expect(response).to have_http_status(:success)
      expect(response.body).to include(employee.firstname)
    end
  end

  describe 'GET /new' do
    it 'returns a successful response' do
      get new_employee_path
      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST /create' do
    it 'creates a new employee and redirects' do
      department = create(:department)
      employee_attributes = attributes_for(:employee).merge(department_id: department.id)
      post employees_path, params: { employee: employee_attributes }

      if response.status == 422 # unprocessable entity
        puts "Errors: #{assigns(:employee).errors.full_messages}"
      end
      expect do
        post employees_path, params: { employee: employee_attributes }
      end.to change(Employee, :count).by(1)
      expect(response).to redirect_to employees_path
      follow_redirect!
      expect(response.body).to include(employee_attributes[:firstname])
    end
  end

  describe 'GET /edit' do
    it 'returns a successful response' do
      employee = create(:employee)
      get edit_employee_path(employee)
      expect(response).to have_http_status(:success)
    end
  end

  describe 'PUT /update' do
    let(:employee) { create(:employee) }
    let(:updated_firstname) { 'Updated Firstname' }

    it 'updates the employee and redirects' do
      put employee_path(employee), params: { employee: { firstname: updated_firstname } }
      expect(response).to redirect_to employees_path
      follow_redirect!
      expect(response.body).to include(updated_firstname)
    end
  end

  describe 'DELETE /destroy' do
    it 'deletes an employee and redirects' do
      employee = create(:employee)
      expect do
        delete employee_path(employee)
      end.to change(Employee, :count).by(-1)
      expect(response).to redirect_to employees_path
    end
  end
end
