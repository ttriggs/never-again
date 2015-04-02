require 'rails_helper'

feature 'visitor views review show' do
  context 'as a guest' do
    let(:user) { FactoryGirl.create(:user) }
    let(:restaurant) { FactoryGirl.build(:restaurant, user: user) }

    scenario 'I do not see an upvote or downvote link' do
      review = FactoryGirl.create(:review, restaurant: restaurant)
      visit review_path(review)

      expect(page).to_not have_link('Upvote Review')
      expect(page).to_not have_link('Downvote Review')
    end
  end
end
