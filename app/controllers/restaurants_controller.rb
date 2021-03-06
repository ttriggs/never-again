class RestaurantsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  def index
    if params[:search]
      @restaurants = Restaurant.search(params[:search]).order('created_at desc').page params[:page]
    else
      @restaurants = Restaurant.order('created_at desc').page params[:page]
    end
  end

  def show
    @restaurant = Restaurant.find(params[:id])
    @reviews = @restaurant.reviews.order('created_at desc').page params[:page]
    @review = Review.new
    @google_query = CGI::escape(@restaurant.address + ", Boston, MA")
  end

  def new
    @restaurant = Restaurant.new
  end

  def edit
    @restaurant = current_user.restaurants.find(params[:id])
  end

  def update
    @restaurant = Restaurant.update(params[:id], restaurant_params)
    if @restaurant.save
      flash[:notice] = "Restaurant saved successfully!"
      redirect_to @restaurant
    else
      flash[:notice] = "Update failed"
      render :new
    end
  end

  def destroy
    @restaurant = current_user.restaurants.find(params[:id])
    @restaurant.destroy
    redirect_to restaurants_path, notice: 'Restaurant deleted successfully!'
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

  private

  # Use callbacks to share common setup or constraints between actions.
  def restaurant_params
    params.require(:restaurant).permit(:name, :address, :city,
                                       :description, :cuisine_id, :image_url)
  end
end
