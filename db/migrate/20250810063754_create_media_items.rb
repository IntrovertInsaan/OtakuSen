# frozen_string_literal: true

class CreateMediaItems < ActiveRecord::Migration[8.0]
  def change
    create_table :media_items do |t|
      t.string :title
      t.text :description
      t.string :status
      t.integer :rating
      t.references :category, null: false, foreign_key: true

      t.timestamps
    end
  end
end
