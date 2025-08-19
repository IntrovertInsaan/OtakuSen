class ForumThreadsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  def index
    @pagy, @threads = pagy(ForumThread.includes(:user, :original_post).order(created_at: :desc))
  end

  def show
    @thread = ForumThread.find(params[:id])
    @pagy, @posts = pagy(@thread.forum_posts.includes(:user).order(created_at: :asc), items: 10)
    @new_post = @thread.forum_posts.new
  end

  def new
    @thread = ForumThread.new
    @thread.forum_posts.build
  end

  def create
    @thread = current_user.forum_threads.new(forum_thread_params)
    # The first post is created with the thread
    @thread.forum_posts.first.user = current_user

    if @thread.save
      redirect_to @thread, notice: "Discussion started!"
    else
      render :new, status: :unprocessable_content
    end
  end

  private

  def forum_thread_params
    params.require(:forum_thread).permit(:title, forum_posts_attributes: [:content])
  end
end
