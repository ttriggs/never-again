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

    visit restaurant_path(restaurant)
    select("2", from: "Rating")
    fill_in("Review", with: "An affront to all five senses")
    click_on("Create Review")

    expect(page).to have_content ("Review saved successfully.")
  end

  scenario "Unathenticated user doesn't see create review link" do
    restaurant = FactoryGirl.create(:restaurant)
    visit restaurant_path(restaurant)

    expect(page).to have_link("Sign in to add a review")

    expect(page).to_not have_link("Create Review")
  end

end


    visit upvote_path(vote)

    visit downvote_path(vote)

    visit upvote_path(vote, method: :delete)
    visit downvote_path(vote, method: :delete)
