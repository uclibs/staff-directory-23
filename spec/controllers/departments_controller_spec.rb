require 'rails_helper'

RSpec.describe DepartmentsController, type: :controller do
  describe 'GET #index' do
    it 'returns a successful response' do
      get :index
      expect(response).to be_successful
    end
  end

  describe 'GET #show' do
    it 'returns a successful response' do
      department = create(:department)
      get :show, params: { id: department.id }
      expect(response).to be_successful
    end
  end

  describe 'GET #new' do
    it 'returns a successful response when user is logged in' do
      sign_in create(:user) # Assuming you have a factory set up for user creation
      get :new
      expect(response).to be_successful
    end
  end

  describe 'POST #create' do
    it 'creates a new department when user is logged in' do
      sign_in create(:user)
      department_params = attributes_for(:department)
      expect {
        post :create, params: { department: department_params }
      }.to change(Department, :count).by(1)
      expect(response).to redirect_to(departments_path)
    end
  end

  describe 'GET #edit' do
    it 'returns a successful response' do
      department = create(:department)
      get :edit, params: { id: department.id }
      expect(response).to be_successful
    end
  end

  describe 'PUT #update' do
    it 'updates the department' do
      department = create(:department)
      new_name = 'New Department Name'
      put :update, params: { id: department.id, department: { name: new_name } }
      department.reload
      expect(department.name).to eq(new_name)
      expect(response).to redirect_to(departments_path)
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the department' do
      department = create(:department)
      expect {
        delete :destroy, params: { id: department.id }
      }.to change(Department, :count).by(-1)
      expect(response).to redirect_to(departments_path)
    end
  end
end
