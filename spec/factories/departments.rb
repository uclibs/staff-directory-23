FactoryBot.define do
  factory :department do
    name { Faker::Lorem.word }
    description { Faker::Lorem.sentence }

    # Create a transient attribute to associate employees with the department
    transient do
      employees_count { 0 }
    end

    # Use a callback to create associated employees
    after(:create) do |department, evaluator|
      create_list(:employee, evaluator.employees_count, department: department)
    end
  end
end
