# frozen_string_literal: true

require "test_helper"

class ForumThreadsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @user = create(:user)
    # ARRANGE: Create a thread that has at least one post for the main tests
    @forum_thread = create(:forum_thread, user: @user)
    create(:forum_post, forum_thread: @forum_thread, user: @user)

    sign_in @user
  end

  test "should get the forum index" do
    # ACT
    get forum_threads_url

    # ASSERT
    assert_response :success
  end

  test "index should not crash for threads with no posts" do
    # ARRANGE: Create a new thread with zero posts
    create(:forum_thread, user: @user, title: "Thread With No Posts")

    # ACT: Visit the index page
    get forum_threads_url

    # ASSERT: The page should load without errors
    assert_response :success
    assert_select "h2", text: "Thread With No Posts"
  end

  test "should show a forum thread" do
    # ACT
    get forum_thread_url(@forum_thread)

    # ASSERT
    assert_response :success
  end

  test "should get new thread page when signed in" do
    # ACT
    get new_forum_thread_url

    # ASSERT
    assert_response :success
  end

  test "should not get new thread page if not signed in" do
    # ARRANGE: Sign out the current user
    sign_out @user

    # ACT
    get new_forum_thread_url

    # ASSERT
    assert_redirected_to new_user_session_url
  end

  test "should create a forum thread with an initial post" do
    # ACT & ASSERT: Check that both a thread and a post are created
    assert_difference([ "ForumThread.count", "ForumPost.count" ], 1) do
      post forum_threads_url, params: {
        forum_thread: {
          title: "New Discussion Title",
          forum_posts_attributes: [
            { content: "This is the first post." }
          ]
        }
      }
    end

    # ASSERT: Check for the correct redirect and success message
    assert_redirected_to forum_thread_url(ForumThread.last)
    assert_equal "Discussion started!", flash[:notice]
  end
end
