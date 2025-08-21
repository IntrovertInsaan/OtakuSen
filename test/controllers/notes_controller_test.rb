# frozen_string_literal: true

require "test_helper"

class NotesControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @user = create(:user)
    @other_user = create(:user)
    @media_item = create(:media_item, user: @user)
    @note = create(:note, media_item: @media_item)
    @other_user_media_item = create(:media_item, user: @other_user)

    # This signs in the user by simulating a form submission.
    post user_session_url, params: { user: { email: @user.email, password: @user.password } }
  end

  test "should get the notes index" do
    get media_item_notes_url(@media_item)
    assert_response :success
  end

  test "should get the new note page" do
    get new_media_item_note_url(@media_item)
    assert_response :success
  end

  test "should create a note and respond with turbo stream" do
    assert_difference("Note.count") do
      post media_item_notes_url(@media_item), params: {
        note: { title: "New Arc", content: "New content" }
      }, as: :turbo_stream
    end

    assert_response :success
    assert_equal "text/vnd.turbo-stream.html; charset=utf-8", response.content_type
  end

  test "should get the edit note page" do
    get edit_media_item_note_url(@media_item, @note)
    assert_response :success
  end

  test "should update a note" do
    patch media_item_note_url(@media_item, @note), params: { note: { title: "Updated Arc Title" } }
    assert_redirected_to media_item_notes_url(@media_item)
  end

  test "should destroy a note and respond with turbo stream" do
    assert_difference("Note.count", -1) do
      delete media_item_note_url(@media_item, @note), as: :turbo_stream
    end

    assert_response :success
    assert_equal "text/vnd.turbo-stream.html; charset=utf-8", response.content_type
  end

  test "should not allow access to another user's media item notes" do
    get media_item_notes_url(@other_user_media_item)
    assert_redirected_to root_url

    # Change the expected message here
    assert_equal "Not authorized", flash[:alert]
  end
end
