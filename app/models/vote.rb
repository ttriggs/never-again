class Vote < ActiveRecord::Base
  class UnknownVotable < Exception; end

  belongs_to :user
  belongs_to :review

  validates :user, presence: true
  validates_uniqueness_of :user, scope: [:vote_id, :review_id]

  after_update :update_vote_cache

  def self.fetch_review(params) #derive votable
    if params[:review_id].present?
      Review.find(params[:review_id])
    else
      raise Vote::UnknownVotable
    end
  end

  def update_vote_cache
    votable.vote_cache = votable.total_votes
    votable.save!
  end

  def increment
    can_upvote? ? update_attributes(score: self.score += 1) : false
  end

  def decrement
    can_downvote? ? update_attributes(score: self.score -= 1) : false
  end

  def upvote_cast?
    score == 1
  end

  def downvote_cast?
    score == -1
  end

  def can_upvote?
    score <= 0
  end

  def can_downvote?
    score >= 0 && score <= 1
  end

  def total_votes
    votes.sum(:score)
  end

  def increment_vote(user)
    fetch_vote(user).increment
  end

  def decrement_vote(user)
    fetch_vote(user).decrement
  end

  private

  def fetch_vote(user, review)
    Vote.find_or_create_by(user: user, review: review)
  end

end
