class MediaItem < ApplicationRecord
  include PgSearch::Model

  belongs_to :category
  has_one_attached :cover_image

  # This is pg_search configuration
  pg_search_scope :search_by_title_and_description,
    against: {
      title: "A",
      description: "B"
    },
    using: {
      tsearch: { prefix: true },
      trigram: {}
    }

  validates :title, presence: true
  validates :status, presence: true
end
