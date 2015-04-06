require "rails_helper"

feature "View all reviews for a restaurant", %q(
  As an user
  I want to view all reviews for a given restaurant
  so I can see just how bad the restaurant is
),focus: true do

  restaurant = FactoryGirl.create(:restaurant)
  next_page_review = FactoryGirl.create(
    :review, restaurant: restaurant, body: "this review is on the next page"
  )
  10.times { reviews << FactoryGirl.create(:review, restaurant: restaurant) }

  scenario "user views all reviews on the first page for a restaurant" do
    visit restaurant_path(restaurant)
    expect(page).to have_content(Review.all.first.rating)
    expect(page).to_not have_content(next_page_review.body)

    click_link "Next"
    expect(page).to have_content(next_page_review.body)
    expect(page).to_not have_content(Review.all.first.body)
  end
end
