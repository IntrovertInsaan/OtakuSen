# frozen_string_literal: true

class ForumThreadsController < ApplicationController
  include Pagy::Backend

  before_action :authenticate_user!, except: [ :index, :show ]

  # GET /forum_threads
  def index
    threads = ForumThread.includes(:user, :original_post).order(created_at: :desc)
    @pagy, @forum_threads = pagy(threads || ForumThread.none)
  end

  # GET /forum_threads/:id
  def show
    @forum_thread = ForumThread.find(params[:id])

    posts = @forum_thread.forum_posts.includes(:user).order(created_at: :asc)
    @pagy, @forum_posts = pagy(posts || ForumPost.none, items: 10)

    @new_forum_post = @forum_thread.forum_posts.new
  end

  # GET /forum_threads/new
  def new
    @forum_thread = ForumThread.new
    @forum_thread.forum_posts.build
  end

  # POST /forum_threads
  def create
    @forum_thread = current_user.forum_threads.new(forum_thread_params)

    @forum_thread.forum_posts.each { |forum_post| forum_post.user = current_user }

    if @forum_thread.save
      redirect_to @forum_thread, notice: "Discussion started!"
    else
      render :new, status: :unprocessable_content
    end
  end

  private

  def forum_thread_params
    params.require(:forum_thread).permit(:title, forum_posts_attributes: [ :content ])
  end
end
