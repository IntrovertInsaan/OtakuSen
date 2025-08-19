class ForumPost < ApplicationRecord
  belongs_to :forum_thread
  belongs_to :user
  has_rich_text :content

  # After a new post is saved, run this code
  after_create_commit do
    # Broadcast a Turbo Stream "append" action to the correct forum thread's channel.
    # Pass the post's creator (user) as a local variable named `current_user`
    broadcast_append_to [ forum_thread, :posts ], partial: "forum_posts/forum_post", locals: { forum_post: self, current_user: self.user }
  end
end
