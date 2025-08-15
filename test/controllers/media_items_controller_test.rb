require "test_helper"

class MediaItemsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @media_item = media_items(:one)
    @user = users(:one)
    sign_in @user # Sign in the user for all actions
  end

  test "should get index" do
    get media_items_url
    assert_response :success
  end

  test "should get new" do
    get new_media_item_url
    assert_response :success
  end

  test "should create media_item" do
    # Ensure we are creating a valid media item
    assert_difference("MediaItem.count") do
      post media_items_url, params: { 
        media_item: { 
          category_id: @media_item.category_id, 
          description: @media_item.description, 
          rating: @media_item.rating, 
          status: @media_item.status, 
          title: "New Test Item", 
          user_id: @user.id 
        } 
      }
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
end
