class CreateCuisine < ActiveRecord::Migration
  def change
    create_table :cuisines do |t|
      t.string "name", null: false
    end
    add_index :cuisines, :name, unique: true
  end
end
