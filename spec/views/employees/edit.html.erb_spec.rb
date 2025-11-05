# frozen_string_literal: true

RSpec.describe 'employees/edit' do
  before do
    @employee = assign(:employee, create(:employee))
  end

  it 'renders the edit employee form' do
    render

    assert_select 'form[action=?][method=?]', employee_path(@employee), 'post' do
    end
  end
end
