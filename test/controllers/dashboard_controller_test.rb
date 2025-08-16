# frozen_string_literal: true

require "test_helper"

class DashboardControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers # Include devise helpers

  setup do
    @user = users(:one)
    sign_in @user # Sign in a user before each test
  end

  test "should get index" do
    get dashboard_url # Use the correct URL helper
    assert_response :success
  end
end
