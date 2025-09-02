# frozen_string_literal: true

class ForumThread < ApplicationRecord
  # --- Associations ---
  belongs_to :user
  has_many :forum_posts, dependent: :destroy
  has_one :original_post, -> { order(created_at: :asc) }, class_name: "ForumPost"

  # --- Nested Attributes ---
  accepts_nested_attributes_for :forum_posts

  # --- Validations ---
  validates :title, presence: true
end
