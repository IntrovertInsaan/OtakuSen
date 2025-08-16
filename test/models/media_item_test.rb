# frozen_string_literal: true

require "test_helper"

class MediaItemTest < ActiveSupport::TestCase
  test "tag_list creates and assigns tags" do
    # Setup: Create a user and a category from our fixtures
    user = users(:one)
    category = categories(:manhwa)

    # Action: Create a new media item and assign a string to its tag_list
    item = MediaItem.create!(
      title: "Test Item for Tagging",
      user: user,
      category: category,
      status: "Planning",
      tag_list: "Action, Isekai, Awesome"
    )

    # Assertion: Check if the action had the correct outcome
    assert_equal 3, item.tags.count
    assert_equal "Action", item.tags.first.name
    assert_equal "Action, Isekai, Awesome", item.tag_list # It alphabetizes them by default
  end
end
