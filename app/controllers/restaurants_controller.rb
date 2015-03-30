class RestaurantsController < ApplicationController

  def index
    @restaurants = Restaurant.order('created_at desc').limit(30)
  end

  def show
    @restaurant = fetch_restaurant
    @review = Review.new
  end

  def new
    @restaurant = Restaurant.new
  end

  def create
    @restaurant = Restaurant.new(restaurant_params)
    @restaurant.user = current_user
    if @restaurant.save
      flash[:notice] = "Restaurant saved successfully!"
      redirect_to @restaurant
    else
      flash[:notice] = "Restaurant failed to save!"
      render :new
    end
  end

  protected

  def fetch_restaurant
    Restaurant.find(params[:id])
  end

  # Use callbacks to share common setup or constraints between actions.
  def restaurant_params
    params.require(:restaurant).permit(:name, :address, :city,
                                       :description, :cuisine_id)
  end
end
