# frozen_string_literal: true

require 'rails_helper'

RSpec.describe EmployeesController, type: :controller do
  include Devise::Test::ControllerHelpers
  before do
    user = FactoryBot.create(:user)
    sign_in user
  end

  describe 'GET #index' do
    it 'renders the index template' do
      get :index
      expect(response).to render_template(:index)
    end

    it 'assigns all employees to @employees' do
      department = FactoryBot.create(:department)
      employee = FactoryBot.create(:employee)
      get :index
      expect(assigns(:employees)).to eq([employee])
    end
  end

  describe 'GET #show' do
    it 'renders the show template' do
      employee = FactoryBot.create(:employee)
      get :show, params: { id: employee.id }
      expect(response).to render_template(:show)
    end

    it 'assigns the requested employee to @employee' do
      employee = FactoryBot.create(:employee)
      get :show, params: { id: employee.id }
      expect(assigns(:employee)).to eq(employee)
    end
  end

  describe 'GET #new' do
    it 'renders the new template' do
      get :new
      expect(response).to render_template(:new)
    end

    it 'assigns a new employee to @employee' do
      get :new
      expect(assigns(:employee)).to be_a_new(Employee)
    end
  end

  describe 'POST #create' do
    context 'with valid parameters' do
      let(:valid_params) do
        { employee: { lastname: 'Doe', firstname: 'John', department_id: FactoryBot.create(:department).id } }
      end

      it 'creates a new employee' do
        expect do
          post :create, params: valid_params
        end.to change(Employee, :count).by(1)
      end

      it 'redirects to the employees index' do
        post :create, params: valid_params
        expect(response).to redirect_to(employees_path)
      end
    end

    context 'with invalid parameters' do
      let(:invalid_params) do
        { employee: { lastname: '', firstname: '', department_id: nil } }
      end

      it 'does not create a new employee' do
        expect do
          post :create, params: invalid_params
        end.not_to change(Employee, :count)
      end

      it 'renders the new template' do
        post :create, params: invalid_params
        expect(response).to render_template(:new)
      end
    end
  end

  describe 'GET #edit' do
    it 'renders the edit template' do
      employee = FactoryBot.create(:employee)
      get :edit, params: { id: employee.id }
      expect(response).to render_template(:edit)
    end

    it 'assigns the requested employee to @employee' do
      employee = FactoryBot.create(:employee)
      get :edit, params: { id: employee.id }
      expect(assigns(:employee)).to eq(employee)
    end
  end

  describe 'PATCH #update' do
    let(:employee) { FactoryBot.create(:employee) }

    context 'with valid parameters' do
      let(:valid_params) do
        { id: employee.id, employee: { lastname: 'Smith' } }
      end

      it 'updates the employee' do
        expect do
          patch :update, params: valid_params
        end.to change { employee.reload.lastname }.to('Smith')
      end

      it 'redirects to the employees index' do
        patch :update, params: valid_params
        expect(response).to redirect_to(employees_path)
      end
    end

    context 'with invalid parameters' do
      let(:invalid_params) do
        { id: employee.id, employee: { lastname: '' } }
      end

      it 'does not update the employee' do
        expect do
          patch :update, params: invalid_params
        end.not_to change(employee, :lastname)
      end

      it 'renders the edit template' do
        patch :update, params: invalid_params
        expect(response).to redirect_to(employees_path)
      end
    end
  end

end

