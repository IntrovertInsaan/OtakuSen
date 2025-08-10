class MediaItem < ApplicationRecord
  belongs_to :category
  has_one_attached :cover_image

  validates :title, presence: true
  validates :status, presence: true
end
