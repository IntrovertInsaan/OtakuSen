# frozen_string_literal: true

require "test_helper"

class ForumThreadsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @user = create(:user)
    @forum_thread = create(:forum_thread, user: @user)
  end

  test "should get the forum index" do
    get forum_threads_url
    assert_response :success
  end

  test "should show a forum thread" do
    get forum_thread_url(@forum_thread)
    assert_response :success
  end

  test "should not get new thread page if not signed in" do
    get new_forum_thread_url
    assert_redirected_to new_user_session_url
  end

  test "should get new thread page when signed in" do
    sign_in @user
    get new_forum_thread_url
    assert_response :success
  end

  test "should create a forum thread with an initial post" do
    sign_in @user

    assert_difference("ForumThread.count") do
      assert_difference("ForumPost.count") do
        post forum_threads_url, params: {
          forum_thread: {
            title: "New Discussion Title",
            forum_posts_attributes: [
              { content: "This is the first post." }
            ]
          }
        }
      end
    end

    assert_redirected_to forum_thread_url(ForumThread.last)
    assert_equal "Discussion started!", flash[:notice]
  end
end
