require 'rails_helper'

feature 'search for restaurants' do
  context 'on the index page' do
    let(:user) { FactoryGirl.create(:user) }

    scenario 'I can use the search bar to search for restaurants by name' do
      restaurant = FactoryGirl.create(:restaurant, name: "8981 Boston")

      visit restaurants_path
      fill_in 'search', with: "898"
      click_on 'Search'

      expect(page).to have_link(restaurant.name)
    end

  end
end
