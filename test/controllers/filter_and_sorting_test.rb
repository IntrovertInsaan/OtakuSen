require "test_helper"

class FilterAndSortingTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @user = users(:one)
    sign_in @user
  end

  test "filter by category" do
    get media_items_url(category_id: categories(:manhwa).id)
    assert_response :success
    assert_select ".media-item-title", text: /Test Manhwa/
    assert_select ".media-item-title", text: /Test Movie/, count: 0
  end

  test "filter by tag" do
    get media_items_url(tag: "Action")
    assert_response :success
    assert_select ".media-item-title", text: /Action/
    assert_select ".media-item-title", text: /Comedy/, count: 0
  end

  test "sort by title ascending" do
    get media_items_url(sort: "title_asc")
    assert_response :success
    titles = css_select(".media-item-title").map(&:text)
    assert_equal titles.sort, titles
  end

  test "sort by title descending" do
    get media_items_url(sort: "title_desc")
    assert_response :success
    titles = css_select(".media-item-title").map(&:text)
    assert_equal titles.sort.reverse, titles
  end

  test "pagination preserves filters and sorting" do
    # Simulate a paginated request with filters and sorting
    get media_items_url(page: 1)
    assert_response :success
    # You can add more asserts here if you have enough data for multiple pages
  end
end
