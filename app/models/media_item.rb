class MediaItem < ApplicationRecord
  belongs_to :category

  validates :title, presence: true
  validates :status, presence: true
end
