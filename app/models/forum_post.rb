class ForumPost < ApplicationRecord
  belongs_to :forum_thread
  belongs_to :user
  has_rich_text :content # Use the WYSIWYG editor
end
