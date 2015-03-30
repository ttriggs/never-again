class Restaurant < ActiveRecord::Base
  belongs_to :user
  belongs_to :cuisine

  has_many :reviews, dependent: :destroy

  validates :user, presence: true

  validates :name, presence: true,
                   uniqueness: true,
                   length: { minimum: 3, maximum: 40 }

  validates :address, presence: true,
                      length: { minimum: 3, maximum: 40 }

  validates :city, presence: true,
                      length: { minimum: 3, maximum: 40 }

  validates :cuisine_id, presence: true
end
