# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'departments/show' do
  before do
    @department = assign(:department, Department.create(name: 'Example Department'))
  end

  it 'renders attributes in <p>' do
    render
  end
end
