class Review < ActiveRecord::Base
  RATINGS = [1, 2, 3, 4, 5]

  belongs_to :user
  belongs_to :restaurant
  has_many :votes, dependent: :destroy

  mount_uploader :image_url, AuxPhotoUploader

  validates :restaurant, presence: true

  validates :user, presence: true

  validates :rating, presence: true,
             inclusion: { in: RATINGS }

  validates_processing_of :image_url

  after_save :update_restaurant_rating_cache

  def update_restaurant_rating_cache
    restaurant.update_rating_cache
  end

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

  def date_submitted
    created_at.strftime("%d-%m-%Y")
  end

  private

  def fetch_vote(user)
    Vote.find_or_create_by(user: user, review: self)
  end
  paginates_per 10
end
