class CreateRestaurants < ActiveRecord::Migration
  def change
    create_table :restaurants do |t|
      t.string :name, null: false
      t.string :address, null: false
      t.string :city, null: false

      t.string :description
      t.integer :cuisine_id, null: false

      t.integer :user_id, null: false

      t.timestamps null: false

    end
  end
end
