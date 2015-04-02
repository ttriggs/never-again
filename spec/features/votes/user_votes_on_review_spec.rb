require 'rails_helper'

feature 'review voting' do
  let(:review) { FactoryGirl.create(:review) }

  context 'as an authorized user' do
    let(:user) { FactoryGirl.create(:user) }

    before :each do
      sign_in_as(user)
    end

    scenario 'up vote a review' do
      visit review_path(review)

      within '.question-votes' do
        find("#upvote").click
      end

      within '.question-votes .total_votes' do
        expect(page).to have_content "1"
      end
      expect(page).to have_content('Upvote saved!')
    end

    scenario 'down vote a review' do
      visit review_path(review)

      within '.question-votes' do
        find("#downvote").click
      end

      within '.question-votes .total_votes' do
        expect(page).to have_content "-1"
      end
      expect(page).to have_content('Downvote saved!')
    end

    scenario 'I cannot down vote a review multiple times' do
      visit review_path(review)

      within '.question-votes' do
        find("#downvote").click
        find("#downvote").click
      end

      within '.question-votes .total_votes' do
        expect(page).to have_content "-1"
      end
      expect(page).to have_content('Already voted on review!')
    end

    scenario 'change up vote to downvote' do
      visit review_path(review)

      within '.question-votes' do
        find("#upvote").click
        find("#downvote").click
        find("#downvote").click
      end

      within '.question-votes .total_votes' do
        expect(page).to have_content "-1"
      end
      expect(page).to have_content('Downvote saved!')
    end

    scenario 'I can delete my up vote' do
      visit review_path(review)

      within '.question-votes' do
        find("#upvote").click
        find("#downvote").click
      end
      within '.question-votes .total_votes' do
        expect(page).to have_content "0"
      end

      expect(page).to have_content('Vote deleted!')
    end
  end

  context 'as a guest' do
    scenario 'I do not see an upvote or downvote arrows' do
      visit review_path(review)

      expect(page).to_not have_selector('#upvote')
      expect(page).to_not have_selector('#downvote')
    end

    scenario "I can see total votes a question has" do
      visit question_path(question)

      expect(page).to have_selector('.total_votes')
    end
  end
end
