# frozen_string_literal: true
require 'rails_helper'
RSpec.describe PublicController, type: :controller  do
  describe('GET #index') {
    it 'returns a success response' do
      @employees = Employee.all
    end
  }
end
