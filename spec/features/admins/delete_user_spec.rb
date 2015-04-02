require "rails_helper"

feature "Delete a user", %q( As an admin I want to be able to delete
  any user, even if it's not my own account) do

  scenario "Admin can delete a user that is not their own account" do
    user = FactoryGirl.create(:user)
    admin = FactoryGirl.create(:admin_user)

    sign_in_as(admin)
    visit user_path(user)
    click_on("Delete user")

    expect(page).to have_content("User deleted")
  end

  scenario "User can not delete a user that is not their own account" do
    user = FactoryGirl.create(:user)
    signed_in_user = FactoryGirl.create(:user)

    sign_in_as(signed_in_user)
    visit user_path(user)

    expect(page).to_not have_content("Delete user")
  end
end
