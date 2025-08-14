require "application_system_test_case"

class MediaItemsTest < ApplicationSystemTestCase
  setup do
    @user = users(:one)
    sign_in @user # Use the Devise helper to sign in the user directly
  end

  test "filters should work together" do
    manhwa_action = media_items(:one)
    manhwa_comedy = media_items(:two)

    visit media_items_url

    # 1. Initially, we should see both items
    assert_text manhwa_action.title
    assert_text manhwa_comedy.title

    # 2. Click on the "Manhwa" category filter
    click_on "Manhwa"

    # We should still see both Manhwa items
    assert_text manhwa_action.title
    assert_text manhwa_comedy.title

    # 3. Now, click on the "Action" tag filter on the first card
    within "#media_item_#{manhwa_action.id}" do
      click_on "Action"
    end

    # 4. ASSERTION: The page should now ONLY show the Action item
    assert_text manhwa_action.title
    assert_no_text manhwa_comedy.title
  end
end
