# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'departments/edit' do
  before do
    @department = assign(:department, Department.create(name: 'Example Department'))
  end

  it 'renders the edit department form' do
    render

    assert_select 'form[action=?][method=?]', department_path(@department), 'post' do
    end
  end
end
