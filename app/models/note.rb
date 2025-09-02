# frozen_string_literal: true

class Note < ApplicationRecord
  # --- Associations ---
  belongs_to :media_item
  has_rich_text :content
end
