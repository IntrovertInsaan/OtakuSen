class Note < ApplicationRecord
  belongs_to :media_item
  has_rich_text :content # This is the WYSIWYG editor field
end
