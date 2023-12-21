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
      FactoryBot.create(:department)
      employee = FactoryBot.create(:employee)
      get :index
      expect(assigns(:employees)).to eq([employee])
    end
    # adding to test sorting
    context 'with valid sorting parameters' do
      it 'sorts by firstname ascending' do
        employee1 = FactoryBot.create(:employee, firstname: 'Alice')
        employee2 = FactoryBot.create(:employee, firstname: 'Bob')
        get :index, params: { sort: 'firstname', direction: 'asc' }
        expect(assigns(:employees)).to eq([employee1, employee2])
      end

      it 'sorts by lastname ascending' do
        # Create two employees with different last names
        employee1 = FactoryBot.create(:employee, lastname: 'Abbott')
        employee2 = FactoryBot.create(:employee, lastname: 'Johnson')
        # Make the request with sorting parameters
        get :index, params: { sort: 'lastname', direction: 'asc' }
        # Add assertions to check the sorting order
        expect(assigns(:employees)).to eq([employee1, employee2])
      end

      # check for sorting by department name
      it 'sorts by department name ascending' do
        # Create departments
        department1 = FactoryBot.create(:department, name: 'Administration')
        department2 = FactoryBot.create(:department, name: 'Content Services')
        # Create employees associated with those departments
        employee1 = FactoryBot.create(:employee, department: department1)
        employee2 = FactoryBot.create(:employee, department: department2)
        # Make the request with sorting parameters
        get :index, params: { sort: 'departments.name', direction: 'asc' }
        # Expect the employees to be sorted in descending order by department name
        expect(assigns(:employees)).to eq([employee1, employee2])
      end

      it 'sorts by title ascending' do
        employee1 = FactoryBot.create(:employee, title: 'Conservation Technician')
        employee2 = FactoryBot.create(:employee, title: 'Network Analyst')
        get :index, params: { sort: 'title', direction: 'asc' }
        expect(assigns(:employees)).to eq([employee1, employee2])
      end
      # Add more tests for each sortable column

      it 'sorts by phone descending' do
        # Create two employees with different last names
        employee1 = FactoryBot.create(:employee, phone: '1234567890')
        employee2 = FactoryBot.create(:employee, phone: '9876543210')
        # Make the request with sorting parameters
        get :index, params: { sort: 'phone', direction: 'desc' }
        # Add assertions to check the sorting order
        expect(assigns(:employees)).to eq([employee2, employee1])
      end

      it 'sorts by email descending' do
        # Create two employees with different last names
        employee1 = FactoryBot.create(:employee, email: 'bob.smith@uc.edu')
        employee2 = FactoryBot.create(:employee, email: 'alice.johnson@uc.edu')
        # Make the request with sorting parameters
        get :index, params: { sort: 'email', direction: 'desc' }
        # Add assertions to check the sorting order
        expect(assigns(:employees).to_a).to eq([employee1, employee2])
      end
    end
  end
  # end of sorting tests context

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
      { employee: {
        lastname: 'Doe',
        firstname: 'John',
        email: 'example@example.com',
        title: 'Manager',
        phone: '1234567890',
        department_id: FactoryBot.create(:department).id
      } }
    end

    it 'creates a new employee' do
      expect do
        post :create, params: valid_params
      end.to change(Employee, :count).by(1)

      puts @controller.instance_variable_get(:@employee).errors.full_messages
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
        expect(response).to render_template(:edit)
      end
    end
  end

  describe 'DELETE #destroy' do
    let!(:employee) { FactoryBot.create(:employee) }

    it 'deletes the employee' do
      expect do
        delete :destroy, params: { id: employee.id }
      end.to change(Employee, :count).by(-1)
    end

    it 'redirects to the employees index' do
      delete :destroy, params: { id: employee.id }
      expect(response).to redirect_to(employees_path)
    end

  end
end

