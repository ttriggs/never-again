class AddRestaurantsRatingCache < ActiveRecord::Migration
  def change
    add_column :restaurants, :rating_cache, :integer, default: 0
  end
end
