require 'rails_helper'

RSpec.describe 'UserLogin' do
  # This assumes you have FactoryBot set up
  let(:user) do
    create(:user, email: 'test@example.com', password: 'password')
  end

  it 'valid inputs' do
    visit new_user_session_path # This path might vary based on your routes

    fill_in 'Email', with: user.email
    fill_in 'Password', with: 'password'
    click_on 'Log in'

    expect(page).to have_content('Signed in successfully')
  end

  it 'invalid inputs' do
    visit new_user_session_path

    fill_in 'Email', with: ''
    fill_in 'Password', with: ''
    click_on 'Log in'

    expect(page).to have_content('Invalid Email or password')
  end
end
