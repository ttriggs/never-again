class ReviewsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  def create
    @restaurant = Restaurant.find(params[:restaurant_id])
    @review = @restaurant.reviews.new(review_params)
    @review.user = current_user
    if @review.save
      ReviewNotifier.new_review(@review).deliver_later
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

  def edit
    @review = current_user.reviews.find(params[:id])
    @restaurant = @review.restaurant
  end

  def update
    @review = Review.update(params[:id], review_params)
    if @review.save
      flash[:notice] = "Review edited."
      redirect_to @review.restaurant
    else
      flash[:notice] = "Update failed"
      render :new
    end
  end

  def destroy
    @review = current_user.reviews.find(params[:id])
    restaurant = @review.restaurant
    @review.destroy
    redirect_to restaurant_path(restaurant), notice: 'Review deleted.'
  end

  private

  def review_params
    params.require(:review).permit(:rating, :body, :rage_level, :image_url)
  end
end
