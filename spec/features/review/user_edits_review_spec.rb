require "rails_helper"

feature "remove a review for a restaurant", %q(
  As a user I want to edit a review I added for a given restaurant
) do

  scenario "Authenticated user unsuccessfully edits a review they made" do
    review = FactoryGirl.create(:review)
    restaurant = review.restaurant
    user = review.user

    sign_in_as(user)

    # user needs to click on edit next to the review that belongs to them
    visit restaurant_review_path(restaurant, review, method: :patch)

    expect(page).to have_content ("Review edited.")
  end

  scenario "Authenticated user unsuccessfully attempts to edit a review they
    did not make" do
    review = FactoryGirl.create(:review)
    restaurant = review.restaurant
    user = restaurant.user
    sign_in_as(user)

    visit restaurant_review_path(restaurant, review, method: :patch)

    expect(page).to have_content ("You can't edit a review that isn't yours.")
  end
end
