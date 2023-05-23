# frozen_string_literal: true

require 'rails_helper'
require 'shoulda/matchers'

RSpec.describe Employee, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:firstname) }
    it { should validate_presence_of(:lastname) }
    it { should validate_presence_of(:email) }
    # Add validations for other fields
  end

  describe 'associations' do
    it { should belong_to(:department) }
  end
end
