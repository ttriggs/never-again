class Like < ActiveRecord::Base
  belongs_to :user
  belongs_to :review

  validates :user, presence: true

end
