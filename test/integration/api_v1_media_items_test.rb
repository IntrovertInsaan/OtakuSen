# frozen_string_literal: true

require "test_helper"

class ApiV1MediaItemsTest < ActionDispatch::IntegrationTest
  setup do
    @user = create(:user)
    # The raw_api_token is available ONLY on the instance
    # that was just created, before it's reloaded from the DB.
    @token = @user.raw_api_token
    @media_item = create(:media_item, user: @user)
  end

  test "should not get index without an API token" do
    get api_v1_media_items_url, as: :json
    assert_response :unauthorized
  end

  test "should get index with a valid API token" do
    # Use the @token variable we captured in setup
    get api_v1_media_items_url,
        headers: { "Authorization" => "Bearer #{@token}" },
        as: :json
    assert_response :success
  end

  test "should show a media item with a valid API token" do
    get api_v1_media_item_url(@media_item),
        headers: { "Authorization" => "Bearer #{@token}" },
        as: :json
    assert_response :success

    json_response = JSON.parse(response.body)
    assert_equal @media_item.title, json_response["title"]
  end
end
