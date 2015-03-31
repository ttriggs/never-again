require "rails_helper"

feature "remove a review for a restaurant", %q(
  As a user I want to remove a review I added for a given restaurant
) do

  scenario "Authenticated user successfully delete a review they made" do
    restaurant = FactoryGirl.create(:restaurant)
    user = FactoryGirl.create(:user)
    sign_in_as(user)

    review_owned_by_user = FactoryGirl.create(:review, restaurant: restaurant, user: user)


    # user needs to click on delete next to the review that belongs to them
    visit restaurant_review_path(restaurant, review_owned_by_user, method: :delete)

    expect(page).to have_content ("Review deleted.")
  end

  scenario "Authenticated user unsuccessfully attempts to delete a review they did not make" do
    restaurant = FactoryGirl.create(:restaurant)
    user = FactoryGirl.create(:user)
    sign_in_as(user)

    review_not_owned_by_user = FactoryGirl.create(:review, restaurant: restaurant)

    visit restaurant_review_path(restaurant, review_not_owned_by_user, method: :delete)

    expect(page).to have_content ("You can't delete a review that isn't yours.")
  end
end
