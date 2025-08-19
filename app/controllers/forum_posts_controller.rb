class ForumPostsController < ApplicationController
  before_action :set_forum_thread

  def create
    @forum_post = @forum_thread.forum_posts.create(forum_post_params)
    @forum_post.user = current_user
    @forum_post.save

    render json: {}, status: :no_content
  end

  private

  def set_forum_thread
    @forum_thread ||= ForumThread.find(params[:forum_thread_id])
  end

  def forum_post_params
    params.require(:forum_post).permit(:content)
  end
end
