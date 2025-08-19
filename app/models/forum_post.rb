class ForumPost < ApplicationRecord
  belongs_to :forum_thread
  belongs_to :user
  has_rich_text :content

  # After a new post is saved, run this code
  after_create_commit do
    # This now broadcasts to the unique string, targeting the correct div
    broadcast_append_later_to "forum_thread_#{self.forum_thread.id}", target: ActionView::RecordIdentifier.dom_id(self.forum_thread), partial: "forum_posts/forum_post", locals: { forum_post: self, current_user: self.user }
  end
end
