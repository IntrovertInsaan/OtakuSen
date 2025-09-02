# frozen_string_literal: true

class Tagging < ApplicationRecord
  # --- Associations ---
  belongs_to :media_item
  belongs_to :tag
end
