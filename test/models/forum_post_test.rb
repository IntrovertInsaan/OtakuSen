# frozen_string_literal: true

require "test_helper"

class ForumPostTest < ActiveSupport::TestCase
  test "should be valid with content, user, and thread" do
    # ARRANGE & ACT: Build a valid post using the factory.
    post = build(:forum_post)

    # ASSERT: Check that it is valid.
    assert post.valid?
  end

  test "should be invalid without content" do
    # ARRANGE & ACT: Build a post with empty content.
    post = build(:forum_post, content: "")

    # ASSERT: Check that it is not valid.
    assert_not post.valid?
  end

  test "should belong to a user" do
    # ARRANGE & ACT: Build a post without a user.
    post = build(:forum_post, user: nil)

    # ASSERT: Check that it is not valid.
    assert_not post.valid?
  end

  test "should belong to a forum_thread" do
    # ARRANGE & ACT: Build a post without a thread.
    post = build(:forum_post, forum_thread: nil)

    # ASSERT: Check that it is not valid.
    assert_not post.valid?
  end
end
