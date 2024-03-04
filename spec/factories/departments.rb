FactoryBot.define do
  factory :department do
    name { Faker::Lorem.word }

    transient do
      employees_count { 0 }
    end

    after(:create) do |department, evaluator|
      create_list(:employee, evaluator.employees_count, department:)
    end
  end
end
