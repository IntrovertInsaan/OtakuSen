require "test_helper"

class MediaItemsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @media_item = media_items(:one)
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
    assert_difference("MediaItem.count") do
      post media_items_url, params: { media_item: { category_id: @media_item.category_id, description: @media_item.description, rating: @media_item.rating, status: @media_item.status, title: @media_item.title } }
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
    patch media_item_url(@media_item), params: { media_item: { category_id: @media_item.category_id, description: @media_item.description, rating: @media_item.rating, status: @media_item.status, title: @media_item.title } }
    assert_redirected_to media_item_url(@media_item)
  end

  test "should destroy media_item" do
    assert_difference("MediaItem.count", -1) do
      delete media_item_url(@media_item)
    end

    assert_redirected_to media_items_url
  end
end
