require "rails_helper"

feature "View all reviews for a restaurant", %q(
  As an user
  I want to view all reviews for a given restaurant
  so I can see just how bad the restaurant is
) do

  scenario "user views all reviews for a restaurant" do
    restaurant = FactoryGirl.create(:restaurant)
    review_one = FactoryGirl.create(:review, restaurant: restaurant)
    review_two = FactoryGirl.create(:review, restaurant: restaurant)

    visit restaurant_path(restaurant)

    expect(page).to have_content (review_one.rating)
    expect(page).to have_content (review_two.body)
  end
end
