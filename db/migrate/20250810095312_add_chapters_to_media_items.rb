class AddChaptersToMediaItems < ActiveRecord::Migration[8.0]
  def change
    add_column :media_items, :chapters_read, :integer
    add_column :media_items, :total_chapters, :integer
  end
end
