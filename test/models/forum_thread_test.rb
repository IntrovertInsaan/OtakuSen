# frozen_string_literal: true

require "test_helper"

class ForumThreadTest < ActiveSupport::TestCase
  def setup
    @user = User.create!(email: "user@example.com", password: "password", username: "testuser")
    @forum_thread = ForumThread.new(title: "Test Thread", user: @user)
  end

  test "should be valid with title and user" do
    assert @forum_thread.valid?
  end

  test "should require title" do
    @forum_thread.title = ""
    assert_not @forum_thread.valid?
  end

  test "should belong to user" do
    assert_equal @user, @forum_thread.user
  end

  test "should allow nested forum posts" do
    post = @forum_thread.forum_posts.build(content: "First post", user: @user)
    assert post.valid?
    @forum_thread.forum_posts << post
    assert_equal 1, @forum_thread.forum_posts.size
  end
end
