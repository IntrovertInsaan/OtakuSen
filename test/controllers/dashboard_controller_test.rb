# frozen_string_literal: true

require "test_helper"

class DashboardControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    # ARRANGE: Create a user from our factory
    @user = create(:user)

    # This signs in the user by simulating a form submission.
    # It is more reliable than the direct `sign_in` helper.
    post user_session_url, params: { user: { email: @user.email, password: @user.password } }
  end

  test "should get index and display correct stats" do
    # ARRANGE: Create unique data using our factories
    category1 = create(:category) # Let the factory generate a unique name
    category2 = create(:category)

    create_list(:media_item, 3, user: @user, category: category1, status: "Completed")
    create_list(:media_item, 2, user: @user, category: category2, status: "In Progress")

    # ACT: Visit the dashboard page
    get dashboard_url

    # ASSERT: Check that the page loads successfully
    assert_response :success

    # ASSERT: Check that the correct data is displayed in the stat cards
    assert_select ".stat-value", text: "5"
    assert_select "li", text: /#{category1.name}\s+3/
    assert_select "li", text: /#{category2.name}\s+2/
  end
end
