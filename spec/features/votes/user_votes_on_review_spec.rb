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
        find('#upvote').click
      end

      within '.review-votes .total-votes' do
        expect(page).to have_content '1 vote'
      end
      expect(page).to have_content('Upvote saved.')
    end

    scenario 'down vote a review' do
      visit restaurant_path(review.restaurant)

      within '.review-votes' do
        find('#downvote').click
      end

      within '.review-votes .total-votes' do
        expect(page).to have_content '-1 votes'
      end
      expect(page).to have_content('Downvote saved.')
    end

    scenario 'I cannot down vote a review multiple times' do
      visit restaurant_path(review.restaurant)

      within '.review-votes' do
        find('#downvote').click
        find('#downvote').click
      end

      within '.review-votes .total-votes' do
        expect(page).to have_content '-1 votes'
      end
      expect(page).to have_content('You have already downvoted.')
    end

    scenario 'change up vote to downvote' do
      visit restaurant_path(review.restaurant)

      within '.review-votes' do
        find('#upvote').click
        find('#downvote').click
        find('#downvote').click
      end

      within '.review-votes .total-votes' do
        expect(page).to have_content '-1 votes'
      end
      expect(page).to have_content('Downvote saved.')
    end

    scenario 'I can delete my up vote' do
      visit restaurant_path(review.restaurant)

      within '.review-votes' do
        find('#upvote').click
        find('#downvote').click
      end
      within '.review-votes .total-votes' do
        expect(page).to have_content '0 votes'
      end

      expect(page).to have_content('Downvote saved.')
    end
  end

  context 'as a guest' do
    scenario 'I do not see an upvote or downvote arrows' do
      visit restaurant_path(review.restaurant)

      expect(page).to_not have_selector('#upvote')
      expect(page).to_not have_selector('#downvote')
    end

    scenario 'I can see total votes a review has' do
      visit restaurant_path(review.restaurant)

      expect(page).to have_selector('.total-votes')
    end
  end
end
