require 'rails_helper'

feature 'review voting' do
  let(:review) { FactoryGirl.create(:review) }

  context 'as an authorized user' do
    let(:user) { FactoryGirl.create(:user) }

    before :each do
      sign_in_as(user)
    end

    scenario 'up vote a review' do
      visit restaurant_path(review.restaurant)

      within '.review-votes' do
        find('#upvote-button').click
      end

      within '.review-votes .total-votes' do
        expect(page).to have_content '1 vote'
      end
      expect(page).to have_content('Upvote saved.')
    end

    scenario 'down vote a review' do
      visit restaurant_path(review.restaurant)

      within '.review-votes' do
        find('#downvote-button').click
      end

      within '.review-votes .total-votes' do
        expect(page).to have_content '-1 votes'
      end
      expect(page).to have_content('Downvote saved.')
    end

    scenario 'I cannot down vote a review multiple times' do
      visit restaurant_path(review.restaurant)

      within '.review-votes' do
        find('#downvote-button').click
        find('#downvote-button').click
      end

      within '.review-votes .total-votes' do
        expect(page).to have_content '-1 votes'
      end
      expect(page).to have_content("Sorry, you're only allowed one Downvote per review.")
    end

    scenario 'change up vote to downvote' do
      visit restaurant_path(review.restaurant)

      within '.review-votes' do
        find('#upvote-button').click
        find('#downvote-button').click
        find('#downvote-button').click
      end

      within '.review-votes .total-votes' do
        expect(page).to have_content '-1 votes'
      end
      expect(page).to have_content('Downvote saved.')
    end

    scenario 'I can delete my up vote' do
      visit restaurant_path(review.restaurant)

      within '.review-votes' do
        find('#upvote-button').click
        find('#downvote-button').click
      end
      within '.review-votes .total-votes' do
        expect(page).to have_content '0 votes'
      end

      expect(page).to have_content('Downvote saved.')
    end
  end
end
