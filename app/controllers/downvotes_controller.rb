class DownvotesController < ApplicationController
  before_action :authenticate_user!

  def create
    review = Review.find(params[:review_id])
    if review.decrement_vote(current_user)
      flash[:success] = "Downvote saved."
    else
      flash[:alert] = "You have already downvoted."
    end

    redirect_to restaurant_path(review.restaurant)
  end
end
