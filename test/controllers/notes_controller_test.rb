# frozen_string_literal: true

require "test_helper"

class NotesControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @user = users(:one)
    @media_item = media_items(:one)
    @note = notes(:one)
    @other_user_media_item = media_items(:three)
    sign_in @user
  end

  test "should get index" do
    get media_item_notes_url(@media_item)
    assert_response :success
  end

  test "should get new" do
    get new_media_item_note_url(@media_item)
    assert_response :success
  end

  test "should create note" do
    assert_difference("Note.count") do
      post media_item_notes_url(@media_item), params: { note: { title: "New Arc" } }
    end
    assert_redirected_to media_item_notes_url(@media_item)
  end

  test "should get edit" do
    get edit_media_item_note_url(@media_item, @note)
    assert_response :success
  end

  test "should update note" do
    patch media_item_note_url(@media_item, @note), params: { note: { title: "Updated Arc Title" } }
    assert_redirected_to media_item_notes_url(@media_item)
  end

  test "should destroy note" do
    assert_difference("Note.count", -1) do
      delete media_item_note_url(@media_item, @note)
    end
    assert_redirected_to media_item_notes_url(@media_item)
  end

  test "should NOT access notes for another user's item" do
    get media_item_notes_url(@other_user_media_item)
    assert_redirected_to root_url
  end
end
