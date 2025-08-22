# frozen_string_literal: true

class DropChatRoomsAndMessages < ActiveRecord::Migration[8.0]
  def change
    drop_table :messages do |t|
      t.text :content
      t.references :user, foreign_key: true
      t.references :chat_room, foreign_key: true
      t.timestamps
    end

    drop_table :chat_rooms do |t|
      t.string :name
      t.timestamps
    end
  end
end
