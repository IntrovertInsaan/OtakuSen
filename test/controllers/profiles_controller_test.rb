# frozen_string_literal: true

require "test_helper"

class ProfilesControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @user = create(:user)
    # This signs in the user by simulating a form submission.
    # It is more reliable than the direct `sign_in` helper.
    post user_session_url, params: { user: { email: @user.email, password: @user.password } }
  end

  test "should get show page for an existing user" do
    get profile_url(@user)
    assert_response :success
  end

  test "should get achievements page for an existing user" do
    get achievements_profile_url(@user)
    assert_response :success
  end

  test "should render not_found page for a non-existent user" do
    non_existent_user_id = User.last.id + 1
    get profile_url(id: non_existent_user_id)
    assert_response :not_found
  end
end
