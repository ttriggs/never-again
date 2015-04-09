require "rails_helper"

feature "Add a review for a restaurant", %q(
  As a user
  I want to add a review for a given restaurant
  so I can tell others just how bad it is
) do

  scenario "Authenticated user successfully adds a review and the user who
    added the restaurant recieves an email" do
    restaurant = FactoryGirl.create(:restaurant)
    user = FactoryGirl.create(:user)
    sign_in_as(user)

    visit restaurant_path(restaurant)
    select("2", from: "Rating")
    fill_in("Review", with: "An affront to all five senses")
    click_on("Create Review")

    expect(page).to have_content ("Review saved successfully.")
  end

  scenario "A review is added and an email is sent to the user that added
    the restaurant being reviewed" do
    restaurant = FactoryGirl.create(:restaurant)
    restaurant_owner = restaurant.user
    reviewer = FactoryGirl.create(:user)
    sign_in_as(reviewer)

    visit restaurant_path(restaurant)
    select("2", from: "Rating")
    fill_in("Review", with: "An affront to all five senses")
    click_on("Create Review")

    expect(ActionMailer::Base.deliveries.count).to eq(1)
    expect(ActionMailer::Base.deliveries.first.to.first).to eq(
      "#{restaurant_owner.email}")
  end

  scenario "Unathenticated user doesn't see create review link" do
    restaurant = FactoryGirl.create(:restaurant)
    visit restaurant_path(restaurant)

    expect(page).to have_link("Sign in to add a review")

    expect(page).to_not have_link("Create Review")
  end

  scenario "I can see picture I add when I write a review" do
    restaurant = FactoryGirl.create(:restaurant)
    reviewer = FactoryGirl.create(:user)
    review = FactoryGirl.create(:review)
    sign_in_as(reviewer)
    visit restaurant_path(review.restaurant)

    within ".review-image" do
      expect(page).to have_css("img")
    end
  end
end
