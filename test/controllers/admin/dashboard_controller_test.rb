# frozen_string_literal: true

require "test_helper"

class Admin::DashboardControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @admin_user = users(:admin) # Use the new admin fixture
    sign_in @admin_user          # Sign in as the admin
  end

  test "should get index" do
    get admin_root_url
    assert_response :success
  end
end
