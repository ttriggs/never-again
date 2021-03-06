class Restaurant < ActiveRecord::Base
  belongs_to :user
  belongs_to :cuisine
  mount_uploader :image_url, AuxPhotoUploader

  has_many :reviews, dependent: :destroy

  validates :cuisine_id, presence: true
  validates :user, presence: true

  validates :name, presence: true,
                   length: { minimum: 3, maximum: 40 }

  validates :address, presence: true,
                      length: { minimum: 3, maximum: 40 }

  validates :city, presence: true,
                      length: { minimum: 3, maximum: 40 }

  validates_processing_of :image_url

  def average_rating
    reviews.average(:rating).to_f.round(1)
  end

  def update_rating_cache
    self.rating_cache = average_rating
    self.save!
  end

  def show_rating
    if rating_cache.nil?
      "No Rating yet. Be the first!"
    else
      "#{rating_cache} bombs"
    end
  end


#validate name & address for scope
  def owner?(current_user)
    user == current_user
  end

  def self.search(search)
    where("name like ?", "%#{search}%")
  end
end
