# frozen_string_literal: true

class ChangeCategoryIdToNullableInMediaItems < ActiveRecord::Migration[8.0]
  def change
    change_column_null :media_items, :category_id, true
  end
end
