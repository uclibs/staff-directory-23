# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Employees', type: :request do
  include Devise::Test::IntegrationHelpers

  let(:user) { FactoryBot.create(:user) }

  describe 'GET /employees' do
    it 'displays the employees index' do
      get employees_path
      expect(response).to have_http_status(200)
      expect(response).to render_template(:index)
    end
  end

  describe 'GET /employees/:id' do
    it 'displays the employee' do
      employee = FactoryBot.create(:employee)
      get employee_path(employee)
      expect(response).to have_http_status(200)
      expect(response).to render_template(:show)
    end
  end

  describe 'GET /employees/new' do
    context 'when user is logged in' do
      before do
        sign_in user
      end

      it 'displays the new employee form' do
        get new_employee_path
        expect(response).to have_http_status(200)
        expect(response).to render_template(:new)
      end
    end

    context 'when user is not logged in' do
      it 'redirects to the sign-in page' do
        get new_employee_path
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe 'POST /employees' do
    context 'when user is logged in' do
      before do
        sign_in user
      end

      context 'with valid parameters' do
        let(:valid_params) do
          { employee: { lastname: 'Smith', firstname: 'John', department_id: FactoryBot.create(:department).id } }
        end

        it 'creates a new employee' do
          expect do
            post employees_path, params: valid_params
          end.to change(Employee, :count).by(1)
        end

        it 'redirects to the employees index' do
          post employees_path, params: valid_params
          expect(response).to redirect_to(employees_path)
        end
      end

      context 'with invalid parameters' do
        let(:invalid_params) do
          { employee: { email: '', encrypted_password: '' } }
        end

        it 'does not create a new employee' do
          expect do
            post employees_path, params: invalid_params
          end.not_to change(Employee, :count)
        end

        it 'renders the new template' do
          post employees_path, params: invalid_params
          expect(response).to have_http_status(422)
          expect(response).to render_template(:new)
        end
      end
    end

    context 'when user is not logged in' do
      it 'redirects to the sign-in page' do
        post employees_path
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe 'GET /employees/:id/edit' do
    context 'when user is logged in' do
      before do
        sign_in user
      end

      it 'displays the edit employee form' do
        employee = FactoryBot.create(:employee)
        get edit_employee_path(employee)
        expect(response).to have_http_status(200)
        expect(response).to render_template(:edit)
      end
    end

    context 'when user is not logged in' do
      it 'redirects to the sign-in page' do
        employee = FactoryBot.create(:employee)
        get edit_employee_path(employee)
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe 'PATCH /employees/:id' do
    context 'when user is logged in' do
      before do
        sign_in user
      end

      let(:employee) { FactoryBot.create(:employee, lastname: 'Stork') }

      context 'with valid parameters' do
        let(:valid_params) do
          { employee: { lastname: 'Updated Lastname' } }
        end

        it 'updates the employee' do
          patch employee_path(employee), params: valid_params
          employee.reload
          expect(employee.lastname).to eq('Updated Lastname')
        end

        it 'redirects to the employees index' do
          patch employee_path(employee), params: valid_params
          expect(response).to redirect_to(employees_path)
        end
      end

      context 'with invalid parameters' do
        let(:invalid_params) do
          { employee: { lastname: nil } }
        end

        it 'does not update the employee' do
          expect do
            patch employee_path(employee), params: invalid_params
            employee.reload
          end.not_to change(employee, :lastname)
        end

        it 'renders the edit template' do
          patch employee_path(employee), params: invalid_params
          expect(response).to have_http_status(302)
          expect(response).to redirect_to(edit_employee_path(employee))
        end
      end
    end

    context 'when user is not logged in' do
      it 'redirects to the sign-in page' do
        employee = FactoryBot.create(:employee)
        patch employee_path(employee)
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe 'DELETE /employees/:id' do
    context 'when user is logged in' do
      before do
        sign_in user
      end

      it 'deletes the employee' do
        employee = FactoryBot.create(:employee)
        expect do
          delete employee_path(employee)
        end.to change(Employee, :count).by(-1)
      end

      it 'redirects to the employees index' do
        employee = FactoryBot.create(:employee)
        delete employee_path(employee)
        expect(response).to redirect_to(employees_path)
      end
    end

    context 'when user is not logged in' do
      it 'redirects to the sign-in page' do
        employee = FactoryBot.create(:employee)
        delete employee_path(employee)
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end
end
