# frozen_string_literal: true

require "test_helper"

class ForumPostsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @user = create(:user)
    @forum_thread = create(:forum_thread, user: @user)
  end

  test "should not allow unauthenticated users to create a post" do
    # ARRANGE & ACT: Try to create a post without signing in
    assert_no_difference("ForumPost.count") do
      post forum_thread_forum_posts_url(@forum_thread), params: { forum_post: { content: "This should fail" } }
    end

    # ASSERT: Should be redirected to the sign-in page
    assert_redirected_to new_user_session_url
  end

  test "should allow an authenticated user to create a post" do
    # ARRANGE: Sign in the user
    sign_in @user

    # ACT & ASSERT: Check that a new post is created
    assert_difference("ForumPost.count") do
      post forum_thread_forum_posts_url(@forum_thread), params: { forum_post: { content: "This is a new post" } }
    end

    # ASSERT: Check for the headless "OK" response
    assert_response :ok
  end
end
