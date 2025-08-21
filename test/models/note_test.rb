# frozen_string_literal: true

require "test_helper"

class NoteTest < ActiveSupport::TestCase
  test "should be valid with a media item" do
    note = build(:note)
    assert note.valid?
  end

  test "should be invalid without a media item" do
    note = build(:note, media_item: nil)
    assert_not note.valid?
  end
end
