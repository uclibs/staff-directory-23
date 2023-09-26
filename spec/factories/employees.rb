FactoryBot.define do
  factory :employee do
    firstname   { Faker::Name.first_name }
    lastname    { Faker::Name.last_name }
    email { Faker::Internet.email }
    phone { Faker::PhoneNumber.phone_number }
    title { ['Software Engineer', 'Product Manager', 'Designer'].sample }
    working_title { title }

    association :department
  end
end
