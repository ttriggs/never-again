require 'rails_helper'

feature 'prevent unuathorized updates to restaurant' do
  context 'as a visitor' do
    scenario 'I cannot save a restaurant' do
      visit new_restaurant_path
      expect(page).to have_content("Log in")
    end

    scenario 'I cannot edit a restaurant' do
      visit edit_restaurant_path("1")
      expect(page).to have_content("Log in")
    end

    scenario 'I cannot delete a restaurant' do
      visit destroy_restaurant_path("1")
      expect(page).to have_content("Log in")
    end
  end

  context 'As a signed in user viewing a restaurant I did not created' do
    before :each do
      restaurant = FactoryGirl.create(:restaurant)
      other_user = FactoryGirl.create(:user)
      sign_in_as other_user
    end

    scenario 'I cannot see edit or delete links on restaurant page'
      visit restaurant_path(restaurant)
      expect(page).to not_have_content("Edit Restaurant")
      expect(page).to not_have_content("Delete Restaurant")
    end

    scenario 'I cannot edit the restaurant' do
      visit edit_restaurant_path(restaurant)
      expect(page).to have_content("Your account is not authorized to view this page")
    end

    scenario 'I cannot delete the restaurant' do
      visit destroy_restaurant_path(restaurant)
      expect(page).to have_content("Your account is not authorized to view this page")
    end
  end
end
