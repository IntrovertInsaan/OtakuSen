# frozen_string_literal: true

require "test_helper"

class FavoriteTest < ActiveSupport::TestCase
  test "should be valid with a user and media item" do
    favorite = build(:favorite)
    assert favorite.valid?
  end

  test "should be invalid without a user" do
    favorite = build(:favorite, user: nil)
    assert_not favorite.valid?
  end

  test "should be invalid without a media item" do
    favorite = build(:favorite, media_item: nil)
    assert_not favorite.valid?
  end
end
