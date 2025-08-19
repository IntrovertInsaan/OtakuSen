class ForumPost < ApplicationRecord
  belongs_to :forum_thread
  belongs_to :user
  has_rich_text :content
  after_commit :notify_forum_thread

  def notify_forum_thread
    broadcast_append_to(
      [ forum_thread, "forum_posts" ],
      target: "forum_posts",
      partial: "forum_posts/forum_post",
      locals: { forum_post: self }
    )
  end
end
