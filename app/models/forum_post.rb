# frozen_string_literal: true

class ForumPost < ApplicationRecord
  belongs_to :forum_thread
  belongs_to :user
  has_rich_text :content

  after_create_commit :notify_forum_thread
  validates :user, :content, presence: true

  def notify_forum_thread
    post = ForumPost.includes(:user).find(self.id)
    post.user&.avatar&.variant(resize_to_fill: [ 40, 40 ])&.processed if post.user&.avatar&.attached?

    broadcast_append_to(
      [ forum_thread, "forum_posts" ],
      target: "forum_posts",
      partial: "forum_posts/forum_post",
      locals: { forum_post: post, current_user: nil }
    )
  end
end
