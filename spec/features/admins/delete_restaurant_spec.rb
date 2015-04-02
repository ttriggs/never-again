require "rails_helper"

feature "Delete a restaurant", %q( As an admin I want to be able to delete
  any restaurant, even if I didn't create it) do

  scenario "Admin can delete restaurant they didn't make" do
    admin = FactoryGirl.create(:user, role: "admin")
    restaurant = FactoryGirl.create(:restaurant)

    sign_in_as(admin)
    visit restaurant_path(restaurant)
    click_on("Delete restaurant")

    expect(page).to have_link("Restaurant has been deleted")
  end
end
