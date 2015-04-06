require "rails_helper"

feature "View a list of users", %q( As an admin I want to view a list of all
the users) do
  let(:admin) { FactoryGirl.create(:user, role: "admin") }
  let(:next_page_user) { FactoryGirl.create(:user, username: "nextpageuser") }

  before :each do
    admin
    next_page_user
    25.times { FactoryGirl.create(:user) }
  end

  scenario "Admin can see a list of all the users on the first page" do
    sign_in_as(admin)
    visit restaurants_path
    click_link("View all users")

    expect(page).to have_content(User.all.last.username)
    expect(page).to_not have_content(next_page_user.username)
  end

  scenario "Admin can see a list of all the users on the next page" do
    sign_in_as(admin)
    visit restaurants_path
    click_link("View all users")
    click_link("Next")

    expect(page).to have_content(next_page_user.username)
    expect(page).to_not have_content(User.all.last.username)
  end

  scenario "Non-admin user can not see all users" do
    user = FactoryGirl.create(:user)

    sign_in_as(user)
    visit restaurants_path

    expect(page).to_not have_link("View all users")
  end
end
