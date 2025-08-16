# frozen_string_literal: true

class AddUserToMediaItems < ActiveRecord::Migration[8.0]
  def change
    add_reference :media_items, :user, foreign_key: true
  end
end
