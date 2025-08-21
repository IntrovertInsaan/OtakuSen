# frozen_string_literal: true

class ForumPostsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_forum_thread
  before_action :set_forum_post, only: [ :edit, :update, :destroy ]
  before_action :authorize_user!, only: [ :edit, :update, :destroy ]

  def create
    @forum_post = @forum_thread.forum_posts.build(forum_post_params)
    @forum_post.user = current_user

    if @forum_post.save
      head :ok
    else
      render json: { error: "Message could not be posted." }, status: :unprocessable_content
    end
  end

  def edit
  end

  def update
    if @forum_post.update(forum_post_params)
      redirect_to @forum_thread, notice: "Reply updated."
    else
      render :edit, status: :unprocessable_content
    end
  end

  def destroy
    @forum_post.destroy
    redirect_to @forum_thread, notice: "Reply deleted."
  end

  private

  def set_forum_thread
    @forum_thread ||= ForumThread.find(params[:forum_thread_id])
  end

  def set_forum_post
    @forum_post = @forum_thread.forum_posts.find(params[:id])
  end

  def authorize_user!
    redirect_to @forum_thread, alert: "Not authorized." unless @forum_post.user == current_user
  end

  def forum_post_params
    params.require(:forum_post).permit(:content)
  end
end
