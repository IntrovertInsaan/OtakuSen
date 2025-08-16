# frozen_string_literal: true

class Tagging < ApplicationRecord
  belongs_to :media_item
  belongs_to :tag
end
