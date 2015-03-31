require "rails_helper"

feature "user forgets password", %{
  As a user, I want to be able to create a new password
  if I forget mine
} do
  scenario "user forgets password, makes new one" do
    visit root
    click_button "Sign in"
    click_link "Forgot your password?"

    expect(page).to have_content("Email")
    expect(page).to have_content("Send me reset password instructions")
  end
end
