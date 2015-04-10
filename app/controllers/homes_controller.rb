class HomesController < ApplicationController
  def index
    @restaurants = Restaurant.all.order('rating_cache desc').limit(7)
  end
end
