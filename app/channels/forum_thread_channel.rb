class ForumThreadChannel < ApplicationCable::Channel
  def subscribed
    # When a user connects, find the specific forum thread they want to listen to.
    @thread = ForumThread.find(params[:id])
    # Create a unique stream name for this thread, e.g., "forum_thread_42"
    stream_for @thread
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
