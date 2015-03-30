class ReviewsController < ApplicationController

  def create
    @restaurant = Restaurant.find(params[:restaurant_id])
    @review = @restaurant.reviews.new(review_params)
    @review.user = current_user
    if @review.save
      flash[:notice] = "Review saved successfully."
      redirect_to @restaurant
    else
      flash[:notice] = "Failed to save your review."
      render 'restaurants/show'
    end
  end

  def new
    @restaurant = Restaurant.find(params[:restaurant_id])
    @review = Review.new
  end

  private

  def review_params
    params.require(:review).permit(:rating, :body)
  end
end

