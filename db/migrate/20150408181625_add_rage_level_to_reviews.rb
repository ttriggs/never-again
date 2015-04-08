class AddRageLevelToReviews < ActiveRecord::Migration
  def change
    add_column :reviews, :rage_level, :string
  end
end
