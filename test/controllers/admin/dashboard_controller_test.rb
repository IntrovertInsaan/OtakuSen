# frozen_string_literal: true

require "test_helper"

class Admin::DashboardControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @admin_user = create(:user, :admin)
    @regular_user = create(:user)
  end

  test "should not allow non-logged-in users to access admin dashboard" do
    # ACT: Visit the admin dashboard without signing in
    get admin_root_url

    # ASSERT: Should be redirected to the sign-in page
    assert_redirected_to new_user_session_url
  end

  test "should not allow non-admin users to access admin dashboard" do
    # ARRANGE: Sign in as a regular user by simulating a login
    post user_session_url, params: { user: { email: @regular_user.email, password: @regular_user.password } }

    # ACT: Visit the admin dashboard
    get admin_root_url

    # ASSERT: Should be redirected away
    assert_redirected_to root_url
  end

  test "should allow admin users to access admin dashboard" do
    # ARRANGE: Sign in as an admin user by simulating a login
    post user_session_url, params: { user: { email: @admin_user.email, password: @admin_user.password } }

    # ACT: Visit the admin dashboard
    get admin_root_url

    # ASSERT: The page should load successfully
    assert_response :success
  end
end
