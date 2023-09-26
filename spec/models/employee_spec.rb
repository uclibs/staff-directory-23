# spec/models/employee_spec.rb
require 'rails_helper'

RSpec.describe Employee, type: :model do
  describe 'Factory' do
    it 'is valid' do
      employee = build(:employee)
      expect(employee).to be_valid
    end
  end

  # You can add more model-specific tests below.
end
