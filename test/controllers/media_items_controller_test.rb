require "test_helper"

class MediaItemsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @user = users(:one)
    @media_item = media_items(:one)
    @other_user_item = media_items(:three)
    sign_in @user
  end

  # --- Basic CRUD Tests ---
  test "should get index" do
    get media_items_url
    assert_response :success
  end

  test "should get new" do
    get new_media_item_url
    assert_response :success
  end

  test "should create media_item" do
    assert_difference("MediaItem.count") do
      post media_items_url, params: { media_item: { category_id: @media_item.category_id, title: "New Test Item", status: "Planning" } }
    end
    assert_redirected_to media_item_url(MediaItem.last)
  end

  test "should show media_item" do
    get media_item_url(@media_item)
    assert_response :success
  end

  test "should get edit" do
    get edit_media_item_url(@media_item)
    assert_response :success
  end

  test "should update media_item" do
    patch media_item_url(@media_item), params: { media_item: { title: "Updated Title" } }
    assert_redirected_to media_item_url(@media_item)
  end

  test "should destroy media_item" do
    assert_difference("MediaItem.count", -1) do
      delete media_item_url(@media_item)
    end
    assert_redirected_to media_items_url
  end

  # --- Custom Action Tests ---

  test "should increment chapter count" do
    # Setup: Give the item a starting chapter count
    @media_item.update(chapters_read: 5, total_chapters: 10)

    patch increment_chapter_media_item_url(@media_item)

    assert_response :success
    assert_equal 6, @media_item.reload.chapters_read
  end

  test "should decrement chapter count" do
    @media_item.update(chapters_read: 5)
    patch decrement_chapter_media_item_url(@media_item)

    assert_response :success
    assert_equal 4, @media_item.reload.chapters_read
  end

  test "should favorite a media item" do
    # Action: Favorite an item
    assert_difference("@user.favorites.count", 1) do
      patch favorite_media_item_url(@other_user_item)
    end

    # Assertion: Check that a redirect happened (we don't care where)
    assert_response :redirect
  end

  test "should unfavorite a media item" do
    # Setup: Ensure the user has favorited the item via fixtures.
    # We assume favorites.yml has a record linking users(:one) and media_items(:three)
    assert @user.favorited_items.include?(@other_user_item)

    # Action: Unfavorite the item
    assert_difference("Favorite.count", -1) do
      patch unfavorite_media_item_url(@other_user_item)
    end

    assert_response :redirect
    assert_not @user.reload.favorited_items.include?(@other_user_item)
  end

  test "should get favorites page" do
    get favorites_media_items_url
    assert_response :success
  end
end
