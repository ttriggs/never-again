require "rails_helper"

feature "remove a review for a restaurant", %q(
  As a user I want to edit a review I added for a given restaurant
) do

  scenario "Authenticated user unsuccessfully edits a review they made" do
    review = FactoryGirl.create(:review)
    restaurant = review.restaurant
    user = review.user

    sign_in_as(user)

    visit restaurant_path(restaurant)
    click_on("Edit Review")

    fill_in("Review", with: "An affront to all five senses")
    click_on("Update Review")

    expect(page).to have_content ("Review edited.")
  end

  scenario "Authenticated user can not see edit button for a review they
    did not make" do
    review = FactoryGirl.create(:review)
    restaurant = review.restaurant
    user = restaurant.user
    sign_in_as(user)

    visit restaurant_path(restaurant)

    expect(page).to_not have_content ("Edit Review")
  end
end
