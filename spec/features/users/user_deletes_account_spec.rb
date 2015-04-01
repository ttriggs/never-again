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

    click_button "My account"
    click_button "Delete"

    visit user_session_path
    fill_in "Username", with: user.username
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "Sign in"

    expect(page).to have_content("Invalid email or password.")
  end
end