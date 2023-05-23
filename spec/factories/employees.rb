# frozen_string_literal: true

FactoryBot.define do
  factory :employee do
    firstname   { 'John' }
    lastname    { 'Haitz' }
    email { 'john.smith@example.com' }
    # use the association method to associate the employee with a department
    association :department
  end
end
