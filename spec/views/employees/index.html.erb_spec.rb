# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'employees/index' do
  include Devise::Test::ControllerHelpers

  before do
    create(:department)
    assign(:employees, Employee.order(lastname: :asc))
  end

  it 'renders a list of employees' do
    render
  end
end
