# spec/factories/users.rb

FactoryBot.define do
  factory :user do
    # Define the attributes for the user factory
    # For example:
    email { 'user@example.com' }
    password { 'password' }
  end
end
