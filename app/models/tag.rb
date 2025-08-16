# frozen_string_literal: true

class Tag < ApplicationRecord
  has_many :taggings, dependent: :destroy
  has_many :media_items, through: :taggings

  validates :name, presence: true, uniqueness: :true
end
