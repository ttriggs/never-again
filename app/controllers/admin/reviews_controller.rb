module Admin
  class ReviewsController < ApplicationController
    before_action :authorize_user

    def destroy
      @review = Review.find(params[:id])
      @review.destroy
      redirect_to restaurant_path(@review.restaurant), notice: "Review deleted"
    end
  end
end
