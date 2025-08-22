# frozen_string_literal: true

class RemoveCropColumnsFromMediaItems < ActiveRecord::Migration[8.0]
  def change
    remove_column :media_items, :crop_x, :integer
    remove_column :media_items, :crop_y, :integer
    remove_column :media_items, :crop_w, :integer
    remove_column :media_items, :crop_h, :integer
  end
end
