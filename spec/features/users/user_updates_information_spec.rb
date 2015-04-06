require "rails_helper"

feature "user updates user information", %{
  As a signed in user, I want to be able to
  update my user information } do
  scenario "update user information" do
    user = FactoryGirl.create(:user)

    visit root_path

    sign_in_as(user)

    click_link "My Account"
    click_link "Edit my Account"

    fill_in "Username", with: "janedoe"
    fill_in "Email", with: "pops@aol.com"
    fill_in "Current password", with: user.password
    fill_in "Avatar", with: "/app/assets/imgages/default_images/default_photo.jpg"

    click_button "Update my Account"

    expect(page).to have_content("Your account has been updated successfully.")
    expect(page).to have_content("janedoe")
    expect(page).to have_content("pops@aol.com")
  end
end
