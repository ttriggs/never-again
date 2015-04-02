class HomesController < ApplicationController
  def index
    @restaurants = Restaurant.all.order('rating asc').limit(10)
  end
end
