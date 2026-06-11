# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'employees/show' do
  before do
    department = Department.create!(name: 'Administration')
    @employee = assign(:employee, Employee.create!(
                                    firstname: 'John',
                                    lastname: 'Doe',
                                    email: 'john.doe@example.com',
                                    title: 'Some title',
                                    phone: '1234567890',
                                    department:
                                  ))
  end

  it 'renders attributes in <p>' do
    render
    # Optionally, you can add assertions here to ensure that the rendered content contains the expected values
    expect(rendered).to include('John')
    expect(rendered).to include('Doe')
    # ... and so on for the other attributes ...
  end
end
