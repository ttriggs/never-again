require "rails_helper"

feature "user updates user information", %{
  As a signed in user, I want to be able to
  update my user information } do
  scenario "update user information" do
    user = FactoryGirl.create(:user)

    visit root_path

    sign_in_as(user)

    visit edit_user_registration_path

    fill_in "Username", with: "janedoe"
    fill_in "Email", with: "pops@aol.com"
    fill_in "Current password", with: user.password

    click_button "Update my Account"

    expect(page).to have_content("Your account has been updated successfully.")

    visit user_path(user)
    expect(page).to have_content("janedoe")
    expect(page).to have_content("pops@aol.com")
  end
end
