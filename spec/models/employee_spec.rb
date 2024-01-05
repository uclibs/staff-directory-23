# spec/models/employee_spec.rb
require 'rails_helper'

RSpec.describe Employee, type: :model do
  describe 'Factory' do
    it 'is valid' do
      department = build(:department) # Explicitly build a Department
      expect(department).to be_valid  # Add this line to check if the department is valid
      employee = build(:employee, department: department) # Assign the built department to the employee
      expect(employee).to be_valid
    end
  end

  # You can add more model-specific tests below.
end
