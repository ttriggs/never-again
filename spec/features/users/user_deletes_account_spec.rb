require "rails_helper"

# As an authenticated user
# I want to delete my account
# So that my information is no longer retained by the app

feature "user deletes account", %{
  As a user, I want to delete my account
  so that my information is no longer retained by the app
} do
  scenario "user deletes account" do
    user = FactoryGirl.create(:user)
    sign_in_as(user)

    click_link "My Account"
    click_link "Edit my Account"

    click_button "Delete my Account"

    expect(page).to have_content("Your account has been successfully deleted.")
  end
end
