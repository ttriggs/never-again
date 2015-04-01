require "rails_helper"

feature "remove a review for a restaurant", %q(
  As a user I want to remove a review I added for a given restaurant
) do

  scenario "Authenticated user successfully delete a review they made" do
    review = FactoryGirl.create(:review)
    user = review.user
    restaurant = review.restaurant

    sign_in_as(user)
    visit restaurant_path(restaurant)
    click_on "Delete review"
    expect(page).to have_content ("Review deleted.")
  end

  scenario "Authenticated user unsuccessfully attempts to delete a review they
    did not make" do
    review = FactoryGirl.create(:review)
    restaurant = review.restaurant
    user = restaurant.user
    sign_in_as(user)
    visit restaurant_path(restaurant)

    expect(page).to_not have_content ("Delete review")
  end
end
