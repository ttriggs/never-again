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

    scenario 'I fail to find a restaurant not matching my search pattern' do
      restaurant = FactoryGirl.create(:restaurant)

      visit restaurants_path
      fill_in 'search', with: "89j1298312io3n123onisfeafe8"
      click_on 'Search'

      expect(page).to_not have_link(restaurant.name)
    end
  end
end
