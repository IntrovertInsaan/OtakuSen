# frozen_string_literal: true

class Category < ApplicationRecord
  # --- Associations ---
  has_many :media_items, dependent: :destroy
  # --- Validations ---
  validates :name, presence: true, uniqueness: true
end
