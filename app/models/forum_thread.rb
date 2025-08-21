# frozen_string_literal: true

class ForumThread < ApplicationRecord
  belongs_to :user
  has_many :forum_posts, dependent: :destroy
  has_one :original_post, -> { order(created_at: :asc) }, class_name: "ForumPost"

  validates :title, presence: true
  accepts_nested_attributes_for :forum_posts
end
