FactoryBot.define do
  factory :employee do
    firstname   { 'Jim' }
    lastname    { 'Shoe' }
    email { 'jim.shoe@example.com' }
    phone { '123-456-7890' }
    title { 'Software Engineer' }
    # use the association method to associate the employee with a department
    # association :department, factory: :department
    # department  { Department.first || association(:department) }
  end
end
