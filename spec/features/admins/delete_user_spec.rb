require "rails_helper"

feature "Delete a user", %q( As an admin I want to be able to delete
  any user, even if it's not my own account) do

  scenario "Admin can delete a user that is not their own account" do
    user = FactoryGirl.create(:user)
    admin = FactoryGirl.create(:user, role: "admin")

    sign_in_as(admin)
    visit user_path(user)
    click_on("Delete user")

    expect(page).to have_content("User deleted")
  end

  scenario "User can not delete a user that is not their own account" do
    user1 = FactoryGirl.create(:user)
    user2 = FactoryGirl.create(:user)

    sign_in_as(user1)
    visit user_path(user2)

    expect(page).to_not have_content("Delete user")
  end
end
