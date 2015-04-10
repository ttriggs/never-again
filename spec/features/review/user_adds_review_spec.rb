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
    choose("star2")
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
    choose("star2")
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

  scenario "I can see a picture from my review" do
    restaurant = FactoryGirl.create(:restaurant)
    reviewer = FactoryGirl.create(:user)
    sign_in_as(reviewer)

    visit restaurant_path(restaurant)
    choose("star2")
    fill_in("Review", with: "An affront to all five senses")
    attach_file("Image url", Rails.root.join("app/assets/images/default_images/profile_default.png"))
    click_on("Create Review")

    within ".review-image" do
      expect(page).to have_css("img")
    end
  end
end
