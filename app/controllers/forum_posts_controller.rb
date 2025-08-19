class ForumPostsController < ApplicationController
  before_action :authenticate_user!

  def create
    @thread = ForumThread.find(params[:forum_thread_id])
    @post = @thread.forum_posts.new(forum_post_params)
    @post.user = current_user

    if @post.save
      # Just redirect back to the thread. The new post will be broadcast to everyone else.
      redirect_to @thread, notice: "Reply posted."
    else
      # If the save fails, we need to reload the page to show the error.
      # We also need to reload the posts to avoid inconsistencies.
      @pagy, @posts = pagy(@thread.forum_posts.includes(:user).order(created_at: :asc), items: 10)
      @new_post = @post # Pass the failed post back to the form
      render "forum_threads/show", status: :unprocessable_content
    end
  end

  private

  def forum_post_params
    params.require(:forum_post).permit(:content)
  end
end
