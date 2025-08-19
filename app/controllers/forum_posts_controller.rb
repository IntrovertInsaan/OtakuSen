class ForumPostsController < ApplicationController
  before_action :authenticate_user!

  def create
    @thread = ForumThread.find(params[:forum_thread_id])
    @post = @thread.forum_posts.new(forum_post_params)
    @post.user = current_user

    if @post.save
      redirect_to @thread, notice: "Reply posted."
    else
      # Handle error case if needed
      redirect_to @thread, alert: "Could not post reply."
    end
  end

  private

  def forum_post_params
    params.require(:forum_post).permit(:content)
  end
end
