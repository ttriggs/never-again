require "rails_helper"

feature "View a list of users", %q( As an admin I want to view a list of all
the users) do

  scenario "Admin can see a list of all the users" do
    admin = FactoryGirl.create(:user, role: "admin")
    next_page_user = FactoryGirl.create(:user, username: "nextpageuser")
    users = Array.new
    25.times { |u| users << FactoryGirl.create(:user) }

    sign_in_as(admin)
    visit restaurants_path
    click_link("View all users")

    expect(page).to have_content(users.last.username)
    expect(page).to_not have_content(next_page_user.username)
    click_link("Next")

    expect(page).to have_content(next_page_user.username)
    expect(page).to_not have_content(users.last.username)
  end

  scenario "Non-admin user can not see all users" do
    user = FactoryGirl.create(:user)

    sign_in_as(user)
    visit restaurants_path

    expect(page).to_not have_link("View all users")
  end
end
