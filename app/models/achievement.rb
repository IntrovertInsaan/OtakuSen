# frozen_string_literal: true

class Achievement < ApplicationRecord
  # --- Associations ---
  has_many :user_achievements, dependent: :destroy
  has_many :users, through: :user_achievements
end
