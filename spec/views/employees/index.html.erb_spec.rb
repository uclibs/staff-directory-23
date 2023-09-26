# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'employees/index', type: :view do
  include Devise::Test::ControllerHelpers

  before(:each) do
    FactoryBot.create(:department)
    assign(:employees, Employee.order(lastname: :asc))
  end

  it 'renders a list of employees' do
    render
  end
end
