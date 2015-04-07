class Review < ActiveRecord::Base
  RATINGS = [1, 2, 3, 4, 5]

  belongs_to :user
  belongs_to :restaurant
  has_many :votes, dependent: :destroy

  validates :restaurant, presence: true

  validates :user, presence: true

  validates :rating, presence: true,
             inclusion: { in: RATINGS }

  def total_votes
    votes.sum(:score)
  end

  def update_vote(user, type)
    if type == "Upvote"
      fetch_vote(user).increment
    elsif type == "Downvote"
      fetch_vote(user).decrement
    else
      false
    end
  end

  private

  def fetch_vote(user)
    Vote.find_or_create_by(user: user, review: self)
  end

  paginates_per 10
end
