require 'factory_girl_rails'

FactoryGirl.define do
  factory :user do
    sequence(:username) { |u| "usename#{u}" }
    sequence(:email) { |n| "user#{n}@example.com" }
    password 'password'
    password_confirmation 'password'
  end

  factory :restaurant do
    name "Captain D's"
    address "34 columbus avenue"
    city "Boston"
    description "hole in the wall fast sea food"

    user
    cuisine
  end

  factory :review do
    body "There's nothing quite like watching cockroaches scurry accross
    the counter top while eating what we've been told is fresh caught sea bass"
    rating 1

    user
    restaurant
  end

  factory :cuisine do
    sequence(:name) { |n| "sea-food#{n}" }
  end

end
