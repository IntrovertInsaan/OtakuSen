# frozen_string_literal: true

require "test_helper"

class MediaItemsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @user = create(:user)
    @other_user = create(:user)
    @media_item = create(:media_item, user: @user)

    # This signs in the user by simulating a form submission.
    # It is more reliable than the direct `sign_in` helper in some contexts.
    post user_session_url, params: { user: { email: @user.email, password: @user.password } }
  end

  # --- Happy Path Tests (Does it work for the owner?) ---

  test "as an authenticated user, can view the media items index" do
    # ACT
    get media_items_url

    # ASSERT
    assert_response :success
  end

  test "as an authenticated user, can create a media item" do
    # ARRANGE
    category = create(:category)

    # ACT & ASSERT
    assert_difference("MediaItem.count") do
      post media_items_url, params: {
        media_item: {
          category_id: category.id,
          title: "New Test Item",
          status: "Planning"
        }
      }
    end

    # ASSERT
    assert_redirected_to media_item_url(MediaItem.last)
    assert_equal "Media item was successfully created.", flash[:notice]
  end

  test "as an authenticated user, can update their own media item" do
    # ACT
    patch media_item_url(@media_item), params: { media_item: { title: "Updated Title" } }

    # ASSERT
    assert_redirected_to media_item_url(@media_item)
    @media_item.reload
    assert_equal "Updated Title", @media_item.title
  end

  test "as an authenticated user, can destroy their own media item" do
    # ACT & ASSERT
    assert_difference("MediaItem.count", -1) do
      delete media_item_url(@media_item)
    end

    # ASSERT
    assert_redirected_to media_items_url
  end

  # --- Unhappy Path / Security Tests ---

  test "should NOT be able to view another user's media item" do
    # ARRANGE
    other_item = create(:media_item, user: @other_user)

    # ACT
    get media_item_url(other_item)

    # ASSERT: The controller should redirect unauthorized users to the root path.
    assert_redirected_to root_url
  end

  test "should NOT be able to destroy another user's media item" do
    # ARRANGE
    other_item = create(:media_item, user: @other_user)

    # ACT & ASSERT
    assert_no_difference("MediaItem.count") do
      delete media_item_url(other_item)
    end

    assert_redirected_to root_url
  end
end
