# frozen_string_literal: true

# test/integration/api_v1_media_items_test.rb
require "test_helper"

class ApiV1MediaItemsTest < ActionDispatch::IntegrationTest
  setup do
    @user = create(:user)
    @media_item = create(:media_item, user: @user)
  end

  test "should not get index without an API token" do
    get api_v1_media_items_url, as: :json
    assert_response :unauthorized
  end

  test "should get index with a valid API token" do
    # Pass the token in the headers, which is the standard for APIs
    get api_v1_media_items_url,
        headers: { "Authorization" => "Bearer #{@user.api_token}" },
        as: :json # Tell the test to request JSON
    assert_response :success
  end

  test "should show a media item with a valid API token" do
    get api_v1_media_item_url(@media_item),
        headers: { "Authorization" => "Bearer #{@user.api_token}" },
        as: :json # Tell the test to request JSON
    assert_response :success

    json_response = JSON.parse(response.body)
    assert_equal @media_item.title, json_response["title"]
  end
end
