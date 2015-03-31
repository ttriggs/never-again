require "rails_helper"

feature "remove a review for a restaurant", %q(
  As a user I want to edit a review I added for a given restaurant
) do

  scenario "Authenticated user unsuccessfully edits a review they made", focus: true do
    restaurant = FactoryGirl.create(:restaurant)
    user = FactoryGirl.create(:user)
    sign_in_as(user)

    review_owned_by_user = FactoryGirl.create(:review, restaurant: restaurant, user: user)

    # user needs to click on edit next to the review that belongs to them
    visit restaurant_review_path(restaurant, review_owned_by_user, method: :patch)

    expect(page).to have_content ("Review deleted.")
  end

  scenario "Authenticated user unsuccessfully attempts to edit a review they did not make" do
    restaurant = FactoryGirl.create(:restaurant)
    user = FactoryGirl.create(:user)
    sign_in_as(user)

    review_not_owned_by_user = FactoryGirl.create(:review, restaurant: restaurant)

    visit restaurant_review_path(restaurant, review_not_owned_by_user, method: :patch)

    expect(page).to have_content ("You can't edit a review that isn't yours.")
  end
end
