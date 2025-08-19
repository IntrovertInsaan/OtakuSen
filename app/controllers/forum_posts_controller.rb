class ForumPostsController < ApplicationController
  before_action :set_forum_thread

  def create
    @forum_post = @forum_thread.forum_posts.create(forum_post_params)
    @forum_post.user = current_user
    @forum_post.save

    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to @forum_thread }
      format.json { head :no_content }
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
