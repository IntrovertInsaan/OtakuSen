# frozen_string_literal: true

require "test_helper"

class CategoryTest < ActiveSupport::TestCase
  test "should be valid" do
    # Uses the factory to build a valid category in memory
    category = build(:category)
    assert category.valid?
  end

  test "should not be valid without a name" do
    category = build(:category, name: "")
    assert_not category.valid?
  end

  test "name should be unique" do
    # ARRANGE: Create the first, valid category.
    # We'll let the factory generate a unique name for us.
    original_category = create(:category)

    # ACT: Create a second category in memory with the exact same name.
    duplicate_category = build(:category, name: original_category.name)

    # ASSERT: Check that the second, unsaved category is not valid.
    assert_not duplicate_category.valid?
    assert_includes duplicate_category.errors[:name], "has already been taken"
  end

  test "should destroy associated media items when destroyed" do
    # Setup: Create a category and a media item belonging to it
    category = create(:category)
    create(:media_item, category: category)

    assert_equal 1, category.media_items.count

    # Action & Assertion: Destroy the category and ensure the item is also destroyed
    assert_difference("MediaItem.count", -1) do
      category.destroy
    end
  end
end
