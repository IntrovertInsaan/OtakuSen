# frozen_string_literal: true

require "test_helper"

class TagTest < ActiveSupport::TestCase
  test "should be valid" do
    tag = build(:tag)
    assert tag.valid?
  end

  test "should require a name" do
    tag = build(:tag, name: "")
    assert_not tag.valid?
  end

  test "name should be unique" do
    original_tag = create(:tag)
    duplicate_tag = build(:tag, name: original_tag.name)
    assert_not duplicate_tag.valid?
  end
end
