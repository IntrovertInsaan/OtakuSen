# frozen_string_literal: true

class ForumPostsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_forum_thread

  def create
    @post = @forum_thread.forum_posts.new(forum_post_params)
    @post.user = current_user

    if @post.save
      # IMPORTANT:
      #   1) We append the new post into #messages (Turbo handles this on subscribers).
      #   2) We send a no-op update to target "reply_modal" so our JS listener closes the dialog.
      #   3) We also reset the form by replacing it with a fresh one (optional quality-of-life).
      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: [
            turbo_stream.append(
              "messages",
              partial: "forum_posts/forum_post",
              locals: { forum_post: @post, current_user: current_user }
            ),
            # Triggers close_reply_modal.js to close the dialog
            turbo_stream.update("reply_modal", ""),
            # Re-render a clean form inside #reply_form_container (defined in the view)
            turbo_stream.replace(
              "reply_form_container",
              partial: "forum_posts/reply_form",
              locals: { forum_thread: @forum_thread, new_post: @forum_thread.forum_posts.new }
            )
          ]
        end

        # Fallback (non-Turbo)
        format.html { redirect_to @forum_thread }
      end
    else
      # Handle validation errors (e.g., blank content)
      render "forum_threads/show", status: :unprocessable_content
    end
  end

  private

  def set_forum_thread
    @forum_thread = ForumThread.find(params[:forum_thread_id])
  end

  def forum_post_params
    params.require(:forum_post).permit(:content)
  end
end
