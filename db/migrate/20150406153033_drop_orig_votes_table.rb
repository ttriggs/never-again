class DropOrigVotesTable < ActiveRecord::Migration
  def up
    drop_table :likes
  end

  def down
    create_table :likes do |t|
      t.integer :user_id, null: false
      t.integer :review_id, null: false
      t.boolean :like, default: false

      t.timestamps null: false
    end
  end
end
