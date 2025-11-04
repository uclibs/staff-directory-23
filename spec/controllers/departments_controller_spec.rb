# frozen_string_literal: true

require 'rails_helper'

RSpec.describe DepartmentsController do
  include Devise::Test::ControllerHelpers

  before do
    user = create(:user)
    sign_in user
  end

  describe 'GET #index' do
    it 'returns a success response' do
      get :index
      expect(response).to be_successful
    end

    it 'assigns all departments as @departments' do
      department = create(:department)
      get :index
      expect(assigns(:departments)).to eq([department])
    end
  end

  describe 'GET #show' do
    it 'returns a success response' do
      department = create(:department)
      get :show, params: { id: department.to_param }
      expect(response).to be_successful
    end

    it 'assigns the requested department as @department' do
      department = create(:department)
      get :show, params: { id: department.to_param }
      expect(assigns(:department)).to eq(department)
    end
  end

  describe 'GET #new' do
    it 'returns a success response' do
      get :new
      expect(response).to be_successful
    end

    it 'assigns a new department as @department' do
      get :new
      expect(assigns(:department)).to be_a_new(Department)
    end
  end

  describe 'GET #edit' do
    it 'returns a success response' do
      department = create(:department)
      get :edit, params: { id: department.to_param }
      expect(response).to be_successful
    end

    it 'assigns the requested department as @department' do
      department = create(:department)
      get :edit, params: { id: department.to_param }
      expect(assigns(:department)).to eq(department)
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new department' do
        expect do
          post :create, params: { department: attributes_for(:department) }
        end.to change(Department, :count).by(1)
      end

      it 'redirects to the department index page' do
        post :create, params: { department: attributes_for(:department) }
        expect(response).to redirect_to(Department)
      end
    end

    context 'with invalid params' do
      it 'does not create a new department' do
        expect do
          post :create, params: { department: attributes_for(:department, name: nil) }
        end.not_to change(Department, :count)
      end

      it 'renders the new template' do
        post :create, params: { department: attributes_for(:department, name: nil) }
        expect(response).to render_template('new')
      end
    end
  end

  describe 'PUT #update' do
    let(:department) { create(:department) }

    context 'with valid params' do
      it 'updates the requested department' do
        new_name = 'New Department Name'
        put :update, params: { id: department.to_param, department: { name: new_name } }
        department.reload
        expect(department.name).to eq(new_name)
      end

      it 'redirects to the updated department page' do
        department = create(:department)
        valid_params = { name: 'New Department Name' }
        put :update, params: { id: department.id, department: valid_params }
        expect(response).to redirect_to(department_path(department))
      end
    end

    context 'with invalid params' do
      it 'does not update the department' do
        old_name = department.name
        put :update, params: { id: department.to_param, department: { name: nil } }
        department.reload
        expect(department.name).to eq(old_name)
      end

      it 'renders the edit template' do
        put :update, params: { id: department.to_param, department: { name: nil } }
        expect(response).to render_template('edit')
      end
    end
  end

  describe 'DELETE #destroy' do
    let!(:department) { create(:department) }

    it 'destroys the requested department' do
      expect do
        delete :destroy, params: { id: department.to_param }
      end.to change(Department, :count).by(-1)
    end

    it 'redirects to the departments list' do
      delete :destroy, params: { id: department.to_param }
      expect(response).to redirect_to(departments_url)
    end
  end
end
