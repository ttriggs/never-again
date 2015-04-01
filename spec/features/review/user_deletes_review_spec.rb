require "rails_helper"

feature "remove a review for a restaurant", %q(
  As a user I want to remove a review I added for a given restaurant
) do

  scenario "Authenticated user successfully delete a review they made" do
    review = FactoryGirl.create(:review)
    user = review.user
    restaurant = restaurant.user

    sign_in_as(user)
    # user needs to click on delete next to the review that belongs to them
    visit restaurant_review_path(restaurant, review, method: :delete)
    expect(page).to have_content ("Review deleted.")

  end

  scenario "Authenticated user unsuccessfully attempts to delete a review they
    did not make", focus: true do
    review = FactoryGirl.create(:review)
    restaurant = review.restaurant
    user = restaurant.user
    sign_in_as(user)

    visit restaurant_review_path(restaurant, review, method: :delete)

    expect(page).to have_content ("You can't delete a review that isn't yours.")
  end
end
