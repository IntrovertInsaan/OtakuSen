# frozen_string_literal: true

require "test_helper"

class FilterAndSortingTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @user = create(:user)
    post user_session_url, params: { user: { email: @user.email, password: @user.password } }
  end

  test "should filter by category" do
    # ARRANGE: Create unique categories and items just for this test.
    category_to_see = create(:category)
    category_to_hide = create(:category)
    item_to_see = create(:media_item, user: @user, category: category_to_see)
    item_to_hide = create(:media_item, user: @user, category: category_to_hide)

    # ACT: Visit the index page filtered by the first category.
    get media_items_url(category_id: category_to_see.id)

    # ASSERT: Check that we see the correct item and not the other one.
    assert_response :success
    assert_select "h2", text: item_to_see.title
    assert_select "h2", { count: 0, text: item_to_hide.title }
  end

  test "should filter by tag" do
    # ARRANGE: Create unique tags and items.
    tag_to_see = create(:tag)
    tag_to_hide = create(:tag)
    item_to_see = create(:media_item, user: @user, tags: [ tag_to_see ])
    item_to_hide = create(:media_item, user: @user, tags: [ tag_to_hide ])

    # ACT: Visit the index page filtered by the first tag.
    get media_items_url(tag: tag_to_see.name)

    # ASSERT: Check that the correct item's title is on the page
    # and the other item's title is not. This now uses the variables.
    assert_response :success
    assert_select "h2", text: item_to_see.title
    assert_select "h2", { count: 0, text: item_to_hide.title }
  end

  test "should sort by title ascending" do
    # ARRANGE: Create items with titles that are easy to sort.
    create(:media_item, user: @user, title: "B Title")
    create(:media_item, user: @user, title: "A Title")
    create(:media_item, user: @user, title: "C Title")

    # ACT: Visit the index page with the ascending sort parameter.
    get media_items_url(sort: "title_asc")

    # ASSERT: Check that the titles on the page appear in the correct alphabetical order.
    assert_response :success
    titles = css_select(".media-item-title a").map(&:text)
    assert_equal [ "A Title", "B Title", "C Title" ], titles
  end
end
