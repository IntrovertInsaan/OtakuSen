# frozen_string_literal: true

class CreateNotes < ActiveRecord::Migration[8.0]
  def change
    create_table :notes do |t|
      t.string :title
      t.references :media_item, null: false, foreign_key: true

      t.timestamps
    end
  end
end
