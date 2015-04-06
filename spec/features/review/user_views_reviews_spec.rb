require "rails_helper"

feature "View all reviews for a restaurant", %q(
  As an user
  I want to view all reviews for a given restaurant
  so I can see just how bad the restaurant is
) do

  scenario "user views all reviews for a restaurant on their appropriate
  pages" do
    restaurant = FactoryGirl.create(:restaurant)
    next_page_review = FactoryGirl.create(
      :review, restaurant: restaurant, body: "this review is on the next page"
    )
    reviews = Array.new
    10.times do |r|
      reviews << FactoryGirl.create(:review, restaurant: restaurant)
    end

    visit restaurant_path(restaurant)
    expect(page).to have_content(reviews.last.rating)
    expect(page).to_not have_content(next_page_review.body)

    click_link "Next"
    expect(page).to have_content(next_page_review.body)
    expect(page).to_not have_content(reviews.last.body)
  end
end
