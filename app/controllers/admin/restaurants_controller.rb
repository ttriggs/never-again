module Admin
  class RestaurantsController < ApplicationController
    before_action :authorize_user

    def destroy
      @restaurant = Restaurant.find(params[:id])
      @restaurant.destroy
      redirect_to restaurants_path, notice: "Restaurant has been deleted"
    end
  end
end
