FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    full_name { Faker::Name.name }
    role { 'user' }
    password { 'password123' } 
    password_confirmation { 'password123' } 
  end

  factory :admin, parent: :user do
    role { 'admin' }
  end
end
