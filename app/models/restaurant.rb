class Restaurant < ActiveRecord::Base
  belongs_to :user
  belongs_to :cuisine

  has_many :reviews, dependent: :destroy

  validates :cuisine_id, presence: true
  validates :user, presence: true

  validates :name, presence: true,
                   length: { minimum: 3, maximum: 40 }

  validates :address, presence: true,
                      length: { minimum: 3, maximum: 40 }

  validates :city, presence: true,
                      length: { minimum: 3, maximum: 40 }

  def average_rating
    reviews.average(:rating).to_f.round(1)
  end

#validate name & address for scope
  def owner?(current_user)
    user == current_user
  end

  def self.search(search)
    where("name like ?", "%#{search}%")
  end
end
