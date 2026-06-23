# frozen_string_literal: true

require 'rails_helper'

RSpec.describe View, type: :model do
  def build_view(email:, password: 'password123')
    described_class.new(
      email:,
      password:,
      password_confirmation: password
    )
  end

  it 'is valid with an email and matching password' do
    view = build_view(email: 'viewer@example.com')

    expect(view).to be_valid
  end

  it 'rejects duplicate email addresses' do
    build_view(email: 'duplicate@example.com').save!
    duplicate = build_view(email: 'duplicate@example.com', password: 'anotherpassword123')

    expect(duplicate).not_to be_valid
    expect(duplicate.errors[:email]).to include('has already been taken')
  end
end
