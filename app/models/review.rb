class Review < ActiveRecord::Base
  RATINGS = [1, 2, 3, 4, 5]

  belongs_to :user
  belongs_to :restaurant
  # has_many :likes, dependent: :destroy

  validates :restaurant, presence: true

  validates :user, presence: true

  validates :rating, presence: true,
             inclusion: { in: RATINGS }

end
