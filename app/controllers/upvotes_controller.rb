class UpvotesController < ApplicationController
  before_action :authenticate_user!

  def create
    review = Review.find(params[:review_id])
    if review.increment_vote(current_user)
      flash[:success] = "Upvote saved."
    else
      flash[:alert] = "You have already upvoted."
    end

    redirect_to restaurant_path(review.restaurant)
  end
end
