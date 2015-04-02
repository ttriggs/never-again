require "rails_helper"

feature "Delete a review", %q( As an admin I want to be able to delete
  any review, even if I didn't create it) do

  scenario "Admin can delete a review they did not make" do
    review = FactoryGirl.create(:review)
    restaurant = review.restaurant
    admin = FactoryGirl.create(:admin_user)

    sign_in_as(admin)
    visit restaurant_path(restaurant)
    click_on("Delete review")

    expect(page).to have_content("Review deleted")
  end
end
