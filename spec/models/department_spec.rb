# frozen_string_literal: true

require 'rails_helper'

require 'shoulda/matchers'

RSpec.describe Department, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:name) }
    # Add validations for other fields
  end

  describe 'associations' do
    it { should have_many(:employees)}
  end
end
