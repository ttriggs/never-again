require 'factory_girl'

FactoryGirl.define do
  factory :user do
    sequence(:username) { |u| "usename#{u}" }
    sequence(:email) { |n| "user#{n}@example.com" }
    password 'password'
  end

  factory :restaurant do
    sequence(:name) { |u| "Captain D's #{u}" }
    address "34 columbus avenue"
    city "Boston"
    description "hole in the wall fast sea food"
    image_url "/app/assets/images/default_images/profile_default.png"

    user
    cuisine
    rating_cache nil
  end

  factory :review do
    body "There's nothing quite like watching cockroaches scurry accross
    the counter top while eating what we've been told is fresh caught sea bass"
    rating 1

    user
    restaurant
  end

  factory :vote do
    user
    review
  end

  factory :cuisine do
    sequence(:name) { |n| "sea-food#{n}" }
  end
end
