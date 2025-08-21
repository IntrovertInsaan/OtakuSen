# frozen_string_literal: true

require "test_helper"

class TaggingTest < ActiveSupport::TestCase
  test "should be valid with a media item and a tag" do
    tagging = build(:tagging)
    assert tagging.valid?
  end

  test "should not be valid without a media item" do
    tagging = build(:tagging, media_item: nil)
    assert_not tagging.valid?
  end

  test "should not be valid without a tag" do
    tagging = build(:tagging, tag: nil)
    assert_not tagging.valid?
  end
end
