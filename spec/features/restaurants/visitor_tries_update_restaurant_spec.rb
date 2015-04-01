require 'rails_helper'

feature 'prevent unuathorized updates to restaurant' do
  context 'as a visitor' do
    scenario 'I cannot save a restaurant' do
      visit new_restaurant_path
      expect(page).to_not have_link("Create Restaurant")
    end

    scenario 'I cannot edit a restaurant' do
      visit edit_restaurant_path("1")
      expect(page).to_not have_link("Edit Restaurant")
    end

    scenario 'I cannot delete a restaurant' do
      restaurant = FactoryGirl.create(:restaurant)

      visit restaurant_path(restaurant, method: :delete)
      expect(page).to_not have_link("Delete Restaurant")
    end
  end

  context 'As a signed in user viewing a restaurant I did not create' do
    before :each do
      @restaurant = FactoryGirl.create(:restaurant)
      user = FactoryGirl.create(:user)
      sign_in_as(user)
    end
  end
end
