require 'rails_helper'

feature 'creating and updating vote' do
  context 'as an authorized user' do
    let(:user) { FactoryGirl.create(:user) }
    let(:restaurant) { FactoryGirl.build(:restaurant, user: user) }

    before :each do
      sign_in_as user
    end

    scenario 'I can successfully up vote a review' do
      review = FactoryGirl.create(:review, restaurant: restaurant)
      visit review_path(review)

      click_button 'Upvote Review'

      expect(page).to have_content('Upvote saved!')
      expect(page).to have_content(restaurant.name)
      expect(page).to have_content(review.body)
    end

    scenario 'I can successfully down vote a review' do
      review = FactoryGirl.create(:review, restaurant: restaurant)
      visit review_path(review)

      click_button 'Downvote Review'

      expect(page).to have_content('Downvote saved!')
      expect(page).to have_content(restaurant.name)
      expect(page).to have_content(review.body)
    end

    scenario 'I cannot up vote a review multiple times' do
      review = FactoryGirl.create(:review, restaurant: restaurant)
      visit review_path(review)

      click_button 'Upvote Review'
      click_button 'Upvote Review'

      expect(page).to have_content('Already voted on review!')
    end

    scenario 'I cannot down vote a review multiple times' do
      review = FactoryGirl.create(:review, restaurant: restaurant)
      visit review_path(review)

      click_button 'Downvote Review'
      click_button 'Downvote Review'

      expect(page).to have_content('Already voted on review!')
    end

    scenario 'I can change up vote to downvote' do
      review = FactoryGirl.create(:review, restaurant: restaurant)
      visit review_path(review)

      click_button 'Upvote Review'
      click_button 'Downvote Review'

      expect(page).to have_content('Downvote saved!')
    end

    scenario 'I can change up vote to downvote' do
      review = FactoryGirl.create(:review, restaurant: restaurant)
      visit review_path(review)

      click_button 'Downvote Review'
      click_button 'Upvote Review'

      expect(page).to have_content('Upvote saved!')
    end

    scenario 'I can delete my up vote' do
      review = FactoryGirl.create(:review, restaurant: restaurant)
      visit review_path(review)

      click_button 'Upvote Review'
      click_button 'Delete Vote'

      expect(page).to have_content('Vote deleted!')
    end

    scenario 'I can delete my down vote' do
      review = FactoryGirl.create(:review, restaurant: restaurant)
      visit review_path(review)

      click_button 'Downvote Review'
      click_button 'Delete Vote'

      expect(page).to have_content('Vote deleted!')
    end
  end
end
