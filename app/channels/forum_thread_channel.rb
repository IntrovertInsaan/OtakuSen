class ForumThreadChannel < ApplicationCable::Channel
  def subscribed
    @thread = ForumThread.find(params[:id])
    # Instead of streaming from the object, stream from a unique string name
    stream_from "forum_thread_#{@thread.id}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
