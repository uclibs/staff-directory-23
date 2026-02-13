# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Employees', type: :feature do
  let(:department) { create(:department, name: 'Engineering') }
  let(:employee) { create(:employee, department: department) }
  let(:user) { create(:user, email: 'staff@example.com', password: 'password') }

  def sign_in_user
    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: 'password'
    click_on 'Log in'
  end

  def create_engineering_department_via_ui
    visit new_department_path
    fill_in 'department_name', with: 'Engineering'
    click_on 'Create Department'
    expect(page).to have_text 'Department was successfully created.'
  end

  def fill_new_employee_form
    fill_in 'employee_firstname', with: employee.firstname
    fill_in 'employee_lastname', with: employee.lastname
    fill_in 'employee_email', with: 'newemployee@example.com'
    fill_in 'employee_phone', with: employee.phone
    fill_in 'employee_title', with: employee.title
    select 'Engineering', from: 'employee_department_id'
    click_on 'Create Employee'
  end

  it 'visiting the index' do
    visit employees_path
    expect(page).to have_css 'h1', text: 'Staff Directory'
    expect(page).to have_text 'Click on column name to sort'
  end

  it 'creating an employee' do
    sign_in_user
    create_engineering_department_via_ui
    visit employees_path
    click_on 'Create New Employee'
    fill_new_employee_form
    expect(page).to have_text 'Employee was successfully created.'
  end

  it 'updating an employee' do
    sign_in_user
    visit edit_employee_path(employee)

    fill_in 'employee_firstname', with: employee.firstname
    fill_in 'employee_lastname', with: employee.lastname
    fill_in 'employee_email', with: employee.email
    fill_in 'employee_phone', with: employee.phone
    fill_in 'employee_title', with: employee.title
    select department.name, from: 'employee_department_id'
    click_on 'Update Employee'

    expect(page).to have_text 'Employee was successfully updated.'
  end

  # Destroy is not exercised here: the Destroy link uses data-confirm (JavaScript),
  # which the default Capybara driver doesn't handle. Deletion is covered by request
  # specs instead (DELETE employee_path), e.g. spec/requests/employees_spec.rb and
  # spec/requests/employees_controller_spec.rb.
end
