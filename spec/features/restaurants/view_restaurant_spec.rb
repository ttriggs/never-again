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

    scenario 'I can view restaurant details that has a rating ' do
      restaurant = FactoryGirl.create(:restaurant)
      FactoryGirl.create(:review, restaurant: restaurant, rating: 1)
      visit restaurants_path
      expect(page).to have_link(restaurant.name)
      click_on restaurant.name

      expect(page).to have_content(restaurant.name)
      expect(page).to have_content(restaurant.description)
      expect(page).to have_content(restaurant.cuisine.name)
      expect(page).to have_content(restaurant.rating_cache)
      expect(page).to have_content('Rating')
      expect(page).to have_content('Reviews')
    end

    scenario 'Restaurant ratins update when I add a new rating' do
      restaurant = FactoryGirl.create(:restaurant)
      FactoryGirl.create(:review, restaurant: restaurant, rating: 1)
      visit restaurant_path(restaurant)
      expect(page).to have_content('Rating: 1')
      FactoryGirl.create(:review, restaurant: restaurant, rating: 3)
      visit restaurant_path(restaurant)
      expect(page).to have_content('Rating: 2')
    end

    scenario 'I am asked to add a review if a restaurant has no rating ' do
      restaurant = FactoryGirl.create(:restaurant)
      visit restaurant_path(restaurant)
      expect(page).to have_content('No Rating yet. Be the first!')
    end
  end
end
