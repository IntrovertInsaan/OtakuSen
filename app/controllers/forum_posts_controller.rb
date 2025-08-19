class ForumPostsController < ApplicationController
  before_action :set_forum_thread

  def create
    @forum_post = @forum_thread.forum_posts.build(forum_post_params)
    @forum_post.user = current_user

    if @forum_post.save
      head :ok   # broadcast happens automatically via after_commit
    else
      flash.now[:alert] = "Message could not be posted."
      redirect_to @forum_thread
    end
  end

  private

  def set_forum_thread
    @forum_thread ||= ForumThread.find(params[:forum_thread_id])
  end

  def forum_post_params
    params.require(:forum_post).permit(:content)
  end
end
