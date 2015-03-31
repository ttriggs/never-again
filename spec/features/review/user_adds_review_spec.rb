require "rails_helper"

feature "Add a review for a restaurant", %q(
  As a user
  I want to add a review for a given restaurant
  so I can tell others just how bad it is
) do

  scenario "Authenticated user successfully adds a review for a restaurant" do
    restaurant = FactoryGirl.create(:restaurant)

    user = FactoryGirl.create(:user)
    sign_in_as(user)

    visit new_restaurant_review_path(restaurant)
    select("2", from: "Rating")
    fill_in("Review", with: "An affront to all five senses")
    click_on("Create Review")

    expect(page).to have_content ("Review saved successfully.")
  end

  scenario "Authenticated user attempts to
    add an incomplete review for a restaurant" do
    restaurant = FactoryGirl.create(:restaurant)

    user = FactoryGirl.create(:user)
    sign_in_as(user)

    visit new_restaurant_review_path(restaurant)
    fill_in("Review", with: "An affront to all five senses")
    click_on("Create Review")

    expect(page).to have_content ("You must select a rating")
  end

  scenario "Inauthenticated user attemps to add a review for a restaurant" do
    restaurant = FactoryGirl.create(:restaurant)
    # We want to stop them from even getting on the new review form page

    visit restaurant_path(restaurant)
    click_on("Add a Review for this Restaurant")

    expect(page).to have_content ("You need to be signed in to do that.")
  end
end
