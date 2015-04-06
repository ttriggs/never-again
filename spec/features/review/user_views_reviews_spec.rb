require "rails_helper"

feature "View all reviews for a restaurant", %q(
  As an user
  I want to view all reviews for a given restaurant
  so I can see just how bad the restaurant is
) do
    let(:restaurant) { FactoryGirl.create(:restaurant) }
    let(:next_page_review) do
      FactoryGirl.create( :review,
      restaurant: restaurant, body: "this review is on the next page")
    end

    before :each do
      next_page_review
      10.times { FactoryGirl.create(:review, restaurant: restaurant) }
    end

    scenario "user views all reviews on the first page for a restaurant" do
      visit restaurant_path(restaurant)

      expect(page).to have_content(Review.all.first.rating)
      expect(page).to_not have_content(next_page_review.body)
    end

    scenario "user views all reviews on the second page for a restaurant" do
      visit restaurant_path(restaurant)
      click_link "Next"

      expect(page).to have_content(next_page_review.body)
      expect(page).to_not have_content(Review.all.last.body)
    end
end
