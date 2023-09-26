# frozen_string_literal: true

require 'rails_helper'
require 'devise'

RSpec.describe 'departments/index', type: :view do
  include Devise::Test::ControllerHelpers
  before(:each) do
    assign(:departments, [
             Department.create!(name: 'Department 1'),
             Department.create!(name: 'Department 2')
           ])
  end

  it 'renders a list of departments' do
    render
  end
end
