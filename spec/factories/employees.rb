FactoryBot.define do
  factory :employee do
    firstname   { 'John'}
    lastname    {'Stork'}
    email { 'jim.shoe@example.com' }
    phone { '123-456-7890' }
    title { 'Software Engineer' }
    pronouns { 'he/him' }
    #use the association method to associate the employee with a department
    association :department
  end
end
