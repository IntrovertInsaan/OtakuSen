# frozen_string_literal: true

require "test_helper"

class ForumThreadTest < ActiveSupport::TestCase
  test "should be valid with a title and user" do
    # ARRANGE & ACT: Build a new forum thread using the factory.
    thread = build(:forum_thread)

    # ASSERT: Check that it is valid.
    assert thread.valid?
  end

  test "should be invalid without a title" do
    # ARRANGE & ACT: Build a thread, but override the title to be blank.
    thread = build(:forum_thread, title: "")

    # ASSERT: Check that it is not valid.
    assert_not thread.valid?
  end

  test "should belong to a user" do
    # ARRANGE: Build a thread without a user.
    thread = build(:forum_thread, user: nil)

    # ACT & ASSERT: Check that it is not valid.
    assert_not thread.valid?
  end

  test "should allow nested forum posts" do
    # ARRANGE: Create a thread in the database.
    thread = create(:forum_thread)

    # ACT: Build a new post that belongs to this thread.
    post = thread.forum_posts.build(content: "First post", user: thread.user)

    # ASSERT: Check that the post is valid and correctly associated.
    assert post.valid?
    assert_equal 1, thread.forum_posts.size
  end
end
