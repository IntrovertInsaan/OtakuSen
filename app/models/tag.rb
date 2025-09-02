# frozen_string_literal: true

class Tag < ApplicationRecord
  # --- Associations ---
  has_many :taggings, dependent: :destroy
  has_many :media_items, through: :taggings

  # --- Validations ---
  validates :name, presence: true, uniqueness: :true
end
