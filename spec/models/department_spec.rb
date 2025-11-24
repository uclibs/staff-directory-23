# spec/models/department_spec.rb
require 'rails_helper'

RSpec.describe Department do
  describe 'Factory' do
    it 'is valid' do
      department = build(:department)
      expect(department).to be_valid
    end
  end

  # Add more department-specific tests.
end
