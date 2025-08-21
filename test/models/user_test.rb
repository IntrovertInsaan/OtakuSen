# frozen_string_literal: true

require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "should be valid with a unique username and email" do
    # `build` creates a new, in-memory user object from our factory
    user = build(:user)
    assert user.valid?, "Factory-built user should be valid"
  end

  test "should not be valid without a username" do
    user = build(:user, username: "")
    assert_not user.valid?, "User should be invalid without a username"
  end

  test "username must be unique and case-insensitive" do
    # `create` saves a user to the test database
    create(:user, username: "testuser")

    # Now try to build another one with the same username but different case
    duplicate_user = build(:user, username: "TestUser")
    assert_not duplicate_user.valid?, "User should be invalid with a duplicate username"
  end

  test "should destroy associated media items when destroyed" do
    # Create a user and give them a media item
    user = create(:user)
    create(:media_item, user: user)

    # Verify they have 1 item to start
    assert_equal 1, user.media_items.count

    # Destroy the user and assert that their media items were also destroyed
    assert_difference("MediaItem.count", -1) do
      user.destroy
    end
  end
end
