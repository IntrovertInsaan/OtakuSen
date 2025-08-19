class ForumPost < ApplicationRecord
  belongs_to :forum_thread
  belongs_to :user
  has_rich_text :content

  # After a new post is saved, run this code
  after_create_commit do
    # This now broadcasts directly to the parent forum_thread's stream
    broadcast_append_to forum_thread, partial: "forum_posts/forum_post", locals: { forum_post: self, current_user: self.user }
  end
end
