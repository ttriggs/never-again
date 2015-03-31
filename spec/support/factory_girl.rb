require 'factory_girl'

FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "user#{n}@example.com" }
    username 'mr_superneato'
    password 'password8'
    password_confirmation 'password8'
  end

  factory :cuisine do
    sequence(:name) { |n| "cuisine #{n}" }
  end

  factory :restaurant do
    sequence(:name) { |n| "restaurant number #{n}" }
    address '1234 address st.'
    city 'boston'
    description 'this is a description'
    cuisine
    user
  end

end
