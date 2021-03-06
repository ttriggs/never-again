class Vote < ActiveRecord::Base
  class UnknownVotable < Exception; end

  belongs_to :user
  belongs_to :review

  validates :user, presence: true
  validates :user, uniqueness: { scope: :review }

  after_update :update_vote_cache

  def self.fetch_review(params)
    if params[:review_id].present?
      Review.find(params[:review_id])
    else
      raise Vote::UnknownVotable
    end
  end

  def update_vote_cache
    review.vote_cache = review.total_votes
    review.save!
  end

  def increment
    can_upvote? ? update_attributes(score: self.score += 1) : false
  end

  def decrement
    can_downvote? ? update_attributes(score: self.score -= 1) : false
  end

  def can_upvote?
    score <= 0
  end

  def can_downvote?
    score >= 0 && score <= 1
  end
end
