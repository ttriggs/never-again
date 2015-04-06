require 'rails_helper'

feature 'view restaurants' do
  context 'as an authorized user' do
    let(:user) { FactoryGirl.create(:user) }

    before :each do
      sign_in_as user
    end

    scenario 'I can see all restaurants on their appropriate pages i.e. paginate
      works' do
      next_page_restaurant = FactoryGirl.create(
        :restaurant, name: "first restaurant"
        )
      restaurants = Array.new
      25.times { |r| restaurants << FactoryGirl.create(:restaurant) }

      visit restaurants_path
      expect(page).to have_link(restaurants.last.name)
      expect(page).to_not have_link(next_page_restaurant.name)

      click_link "Next"

      expect(page).to have_link(next_page_restaurant.name)
    end

    scenario 'I can view a restaurants details' do
      restaurant = FactoryGirl.create(:restaurant)

      visit restaurants_path
      expect(page).to have_link(restaurant.name)
      click_on restaurant.name

      expect(page).to have_content(restaurant.name)
      expect(page).to have_content(restaurant.description)
      expect(page).to have_content(restaurant.address)
      expect(page).to have_content(restaurant.city)
      expect(page).to have_content(restaurant.cuisine.name)
      expect(page).to have_content('Rating')
      expect(page).to have_content('Reviews')
    end
  end
end
