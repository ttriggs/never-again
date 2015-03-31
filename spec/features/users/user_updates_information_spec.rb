require "rails-helper"

feature "user updates user information", %{
  As a signed in user, I want to be able to
  update my user information } do
  scenario "update user information" do
    user1 = FactoryGirl.create(:user)
    user2 = FactoryGirl.create(:user)

    visit root
    click_button "Sign in"
    fill_in "Email", with: user1.email
    fill_in "Password", with: user1.password

    click_button "My account"
    fill_in "Email", with: user2.email
    fill_in "Password", with: user2.email

    click_button "Save changes"

    expect(page).to have_content(user2.email)
    expect(page).to have_content(user2.password)
  end
end
