require 'rails_helper'

feature 'view restaurants' do
  context 'as an authorized user' do
    let(:user) { FactoryGirl.create(:user) }
    let(:next_page_restaurant) do
      FactoryGirl.create(:restaurant, name: "first restaurant")
    end


    before :each do
      sign_in_as user
      next_page_restaurant
    end

    scenario 'I can see all restaurants on the first page' do
      25.times { FactoryGirl.create(:restaurant) }

      visit restaurants_path
      expect(page).to have_link(Restaurant.all.last.name)
      expect(page).to_not have_link(next_page_restaurant.name)

      click_link "Next"

      expect(page).to have_link(next_page_restaurant.name)
    end

    scenario 'I can see all restaurants on the next page' do
      25.times { FactoryGirl.create(:restaurant) }

      visit restaurants_path
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
