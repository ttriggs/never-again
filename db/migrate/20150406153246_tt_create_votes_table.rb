class TtCreateVotesTable < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.integer :user_id, null: false
      t.integer :review_id, null: false
      t.integer :score, default: 0

      t.timestamps null: false
    end
    add_index :votes, [:user_id, :review_id], unique: true
  end
end
