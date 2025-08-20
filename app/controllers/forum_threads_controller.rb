class ForumThreadsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  def index
    @pagy, @forum_threads = pagy(
      ForumThread.includes(:user, :original_post).order(created_at: :desc)
    )
  end

  def show
    @forum_thread = ForumThread.find(params[:id])
    @pagy, @forum_posts = pagy(
      @forum_thread.forum_posts.includes(:user).order(created_at: :asc),
      items: 10
    )
    @new_forum_post = @forum_thread.forum_posts.new
  end

  def new
    @forum_thread = ForumThread.new
    @forum_thread.forum_posts.build
  end

  def create
    @forum_thread = current_user.forum_threads.new(forum_thread_params)

    # Assign current_user to all nested forum_posts
    @forum_thread.forum_posts.each { |forum_post| forum_post.user = current_user }

    if @forum_thread.save
      redirect_to @forum_thread, notice: "Discussion started!"
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def forum_thread_params
    params.require(:forum_thread).permit(:title, forum_posts_attributes: [:content])
  end
end
