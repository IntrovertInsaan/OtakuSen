# frozen_string_literal: true

class AddDisplayNameToAchievements < ActiveRecord::Migration[8.0]
  def change
    add_column :achievements, :display_name, :string
  end
end
