class AddVoteCacheColToReviewsTable < ActiveRecord::Migration
  def change
    add_column :reviews, :vote_cache, :integer, default: 0
  end
end
