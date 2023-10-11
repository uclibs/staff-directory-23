require 'rails_helper'

RSpec.feature "UserLogin", type: :feature do
  let(:user) { create(:user, email: 'test@example.com', password: 'password') } # This assumes you have FactoryBot set up

  scenario "valid inputs" do
    visit new_user_session_path  # This path might vary based on your routes

    fill_in 'Email', with: user.email
    fill_in 'Password', with: 'password'
    click_on 'Log in'

    expect(page).to have_content('Signed in successfully')
  end

  scenario "invalid inputs" do
    visit new_user_session_path

    fill_in 'Email', with: ''
    fill_in 'Password', with: ''
    click_on 'Log in'

    expect(page).to have_content('Invalid Email or password')
  end
end
