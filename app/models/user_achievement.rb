# frozen_string_literal: true

class UserAchievement < ApplicationRecord
  # --- Associations ---
  belongs_to :user
  belongs_to :achievement
end
