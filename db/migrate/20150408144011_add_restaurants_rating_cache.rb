class AddRestaurantsRatingCache < ActiveRecord::Migration
  def change
    add_column :restaurants, :rating_cache, :float, default: 0
  end
end
