class ForumPost < ApplicationRecord
  belongs_to :forum_thread
  belongs_to :user
  has_rich_text :content

  # This tells the model to automatically broadcast new posts
  # to its parent forum_thread's stream, targeting the
  # container with the ID "forum_thread_1_posts".
  broadcasts_to :forum_thread, target: ->(post) { dom_id(post.forum_thread, :posts) }
end
