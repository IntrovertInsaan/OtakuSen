# frozen_string_literal: true

require "test_helper"

class ForumPostTest < ActiveSupport::TestCase
  def setup
    @user = User.create!(email: "user@example.com", password: "password", username: "testuser")
    @forum_thread = ForumThread.create!(title: "Thread", user: @user)
    @forum_post = ForumPost.new(content: "Hello world", forum_thread: @forum_thread, user: @user)
  end

  test "should be valid with content, user, and forum_thread" do
    assert @forum_post.valid?
  end

  test "should require content" do
    @forum_post.content = ""
    assert_not @forum_post.valid?
  end

  test "should belong to forum_thread" do
    assert_equal @forum_thread, @forum_post.forum_thread
  end

  test "should belong to user" do
    assert_equal @user, @forum_post.user
  end
end
