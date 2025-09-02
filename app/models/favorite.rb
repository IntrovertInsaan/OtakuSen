# frozen_string_literal: true

class Favorite < ApplicationRecord
  # --- Associations ---
  belongs_to :user
  belongs_to :media_item
end
