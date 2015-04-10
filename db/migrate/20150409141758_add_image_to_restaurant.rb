class AddImageToRestaurant < ActiveRecord::Migration
  def change
    add_column :restaurants, :image_url, :string, default: ""
  end
end
