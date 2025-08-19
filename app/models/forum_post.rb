class ForumPost < ApplicationRecord
  belongs_to :forum_thread
  belongs_to :user
  has_rich_text :content

  attr_accessor :user_id_for_view   # temporarily store current_user.id for view

  after_commit :notify_forum_thread

  def notify_forum_thread
    # Preload avatar variant so image shows immediately in broadcasts
    if user&.avatar&.attached?
      user.avatar.variant(resize_to_fill: [40, 40]).processed
    end

    broadcast_append_to(
      [ forum_thread, "forum_posts" ],
      target: "forum_posts",
      partial: "forum_posts/forum_post",
      locals: { forum_post: self }
    )
  end
end
