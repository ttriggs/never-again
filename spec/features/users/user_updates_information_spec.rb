require "rails-helper"

feature "user updates user information", %{
  As a signed in user, I want to be able to
  update my user information } do
  scenario "update user information" do
    user = FactoryGirl.create(:user)

    visit root

    sign_in_as user

    click_button "My account"

    fill_in "Email", with: "pops@aol.com"
    fill_in "Password", with: "12345678"

    click_button "Save changes"

    expect(page).to have_content("pops@aol.com")
    expect(page).to have_content("12345678")
  end
end
