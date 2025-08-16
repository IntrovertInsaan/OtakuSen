# frozen_string_literal: true

class MediaItem < ApplicationRecord
  include PgSearch::Model

  belongs_to :user
  belongs_to :category
  has_one_attached :cover_image

  has_many :taggings, dependent: :destroy
  has_many :tags, through: :taggings

  has_many :favorites, dependent: :destroy

  has_many :notes, dependent: :destroy

  # This is a "getter" method to display the tags as a string
  def tag_list
    tags.map(&:name).join(", ")
  end

  # This is a "setter" method to find or create tags from a string
  def tag_list=(names)
    self.tags = names.split(",").map do |n|
      Tag.where(name: n.strip).first_or_create!
    end
  end

  # This is pg_search configuration
  pg_search_scope :search_by_all_content,
    against: {
      title: "A",
      description: "B"
    },
    associated_against: {
      tags: { name: "A" }
    },

    using: {
      tsearch: { prefix: true },
      trigram: {}
    }

  validates :title, presence: true
  validates :status, presence: true
end
