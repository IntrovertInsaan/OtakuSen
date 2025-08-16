# frozen_string_literal: true

class Category < ApplicationRecord
  has_many :media_items, dependent: :destroy
  validates :name, presence: true, uniqueness: true
end
