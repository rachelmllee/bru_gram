class Photo < ActiveRecord::Base
  belongs_to :user
  has_many :comments
  validates :image_url, presence: true
end
