class VotesController < ApplicationController
  before_action :authenticate_user!

  def create
    review = Review.find(params[:review_id])
    type = params[:type]
    if review.update_vote(current_user, type)
      flash[:success] = "#{type} saved."
    else
      flash[:alert] = "Sorry, you're only allowed one #{type} per review."
    end

    redirect_to restaurant_path(review.restaurant)
  end
end
