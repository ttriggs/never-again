require "rails_helper"

feature "Delete a user", %q( As an admin I want to be able to delete
  any user, even if it's not my own account) do

  scenario "Admin can delete a user that is not their own account" do
    admin = FactoryGirl.create(:user, role: "admin")
    user = FactoryGirl.create(:user)

    sign_in_as(admin)
    visit admin_users_path
    within(".user-details:first-child") { click_on("Delete user") }

    expect(page).to have_content("User deleted")
  end
end
