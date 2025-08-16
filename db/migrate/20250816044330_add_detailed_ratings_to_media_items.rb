# frozen_string_literal: true

class AddDetailedRatingsToMediaItems < ActiveRecord::Migration[8.0]
  def change
    add_column :media_items, :story_rating, :integer
    add_column :media_items, :art_rating, :integer
    add_column :media_items, :characters_rating, :integer
  end
end
