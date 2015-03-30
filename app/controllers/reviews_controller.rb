class ReviewsController < ApplicationController

  def create
    @restaurant = fetch_restaurant
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
    @restaurant = fetch_restaurant
    @review = Review.new
  end

  protected

  def fetch_restaurant
    Restaurant.find(params[:restaurant_id])
  end

  def review_params
    params.require(:review).permit(:rating, :body)
  end
end

