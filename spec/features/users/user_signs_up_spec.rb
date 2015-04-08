require "rails_helper"

feature "user registers", %{
  As a visitor
  I want to register
  So that I can create an account
} do
  scenario "provide valid registration information" do
    visit new_user_registration_path

    fill_in "Username", with: "johndoe"
    fill_in "Email", with: "john@example.com"
    fill_in "Password", with: "password"
    fill_in "Password confirmation", with: "password"
    attach_file("Profile photo", Rails.root.join("app/assets/images/default_images/thumb_default_photo.jpg"))

    click_button "Sign up"

    expect(page).to have_content("Welcome! You have signed up successfully.")
    expect(page).to have_content("Sign Out")
  end

  scenario "provide default profile image" do
    visit new_user_registration_path

    user = FactoryGirl.create(:user, profile_photo: nil )

    visit new_user_session_path

    sign_in_as(user)

    visit user_path(user)

    within "#profile-photo" do
      expect(page).to have_css("img")
    end
  end

  scenario "provide invalid registration information" do
    visit new_user_registration_path

    click_button "Sign up"
    expect(page).to have_content("can't be blank")
    expect(page).to_not have_content("Sign Out")
  end
end
