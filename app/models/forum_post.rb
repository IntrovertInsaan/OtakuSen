class ForumPost < ApplicationRecord
  belongs_to :forum_thread
  belongs_to :user
  has_rich_text :content

  # After a new post is saved, run this code
  after_create_commit do
    # Broadcast a Turbo Stream "append" action to the correct forum thread's channel.
    # It will use a new partial to render the post.
    broadcast_append_to forum_thread, partial: "forum_posts/forum_post", locals: { forum_post: self }
  end
end
