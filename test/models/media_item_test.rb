# frozen_string_literal: true

require "test_helper"

class MediaItemTest < ActiveSupport::TestCase
  test "should be valid with all required attributes" do
    # `build(:media_item)` automatically creates a valid user and category for us
    item = build(:media_item)
    assert item.valid?
  end

  test "should be invalid without a title" do
    item = build(:media_item, title: "")
    assert_not item.valid?, "Saved the item without a title"
  end

  test "should be invalid without a status" do
    item = build(:media_item, status: "")
    assert_not item.valid?, "Saved the item without a status"
  end

  test "tag_list= creates and assigns tags from a string" do
    item = create(:media_item)

    # Action: Assign a string of tags
    item.tag_list = "Action, Isekai, Adventure"

    # Assertion: Check that the correct tags were created and associated
    assert_equal 3, item.tags.count
    # `pluck` is an efficient way to get just the names
    assert_equal [ "Action", "Isekai", "Adventure" ], item.tags.pluck(:name)
  end

  test "tag_list returns a comma-separated string in the correct order" do
    item = create(:media_item)

    # Setup: Manually create and assign tags in a specific order
    item.tags << Tag.create!(name: "Second Tag")
    item.tags << Tag.create!(name: "First Tag")

    # Assertion: Check that the getter method returns the string in the order of creation
    assert_equal "Second Tag, First Tag", item.tag_list
  end
end
