class Review < ActiveRecord::Base
  RATINGS = [1, 2, 3, 4, 5]

  belongs_to :user
  belongs_to :restaurant
  # has_many :likes, dependent: :destroy

  validates :user, presence: true
  validates :rating, presence: true, numericality: { minimum: RATINGS[0], maximum: RATINGS[-1]}

end
