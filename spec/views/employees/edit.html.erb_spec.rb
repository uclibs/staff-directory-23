# frozen_string_literal: true

RSpec.describe 'employees/edit', type: :view do
  before(:each) do
    @employee = assign(:employee, FactoryBot.create(:employee))
  end

  it 'renders the edit employee form' do
    render

    assert_select 'form[action=?][method=?]', employee_path(@employee), 'post' do
    end
  end
end
