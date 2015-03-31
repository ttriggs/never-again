require 'rails_helper'

feature 'creating and updating restaurants' do
  context 'as an authorized user' do
    let(:user) { FactoryGirl.create(:user) }
    let(:restaurant) { FactoryGirl.build(:restaurant, user: user) }

    before :each do
      sign_in_as user
    end

    scenario 'I can successfully create a restaurant' do
      visit new_restaurant_path

      fill_in 'Name', with: restaurant.name
      fill_in 'Address', with: restaurant.address
      fill_in 'City', with: restaurant.city
      fill_in 'Description', with: restaurant.description
      find('#restaurant_cuisine_id').find(:xpath, 'option[1]').select_option
      click_on 'Create Restaurant'

      expect(page).to have_content('Restaurant saved successfully!')
      expect(page).to have_content(restaurant.name)
    end

    scenario 'I can see edit and delete links for a restaurant I created' do
      restaurant = FactoryGirl.create(:restaurant, user: user)
      visit restaurant_path(restaurant)

      expect(page).to have_link('Edit')
      expect(page).to have_link('Delete')
    end

    scenario 'I can update a restaurant I create' do
      restaurant = FactoryGirl.create(:restaurant, user: user)
      visit edit_restaurant_path(restaurant)

      # should be on the edit page for edited restaurant
      fill_in 'Name', with: 'edited name'
      fill_in 'Address', with: 'edited address'
      click_on 'Save Changes'

      # should be on the show page for edited restaurant
      expect(page).to have_content('Restaurant saved successfully!')
      expect(page).to have_content('edited name')
      expect(page).to have_content('edited address')
    end

    scenario 'I can delete a restaurant I created' do
      restaurant = FactoryGirl.create(:restaurant, user: user)
      visit restaurant_path(restaurant)
      click_on 'Delete Restaurant'

      # should be on restaurants index page
      expect(page).to have_content('Restaurant deleted successfully!')
      expect(page).to not_have_content(restaurant.name)
    end
  end
end
