# frozen_string_literal: true

require "test_helper"

class Users::RegistrationsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @user = users(:one)
    sign_in @user
  end

  test "should get edit profile page" do
    get edit_user_registration_url
    assert_response :success
  end

  test "should update username and bio without current password" do
    patch user_registration_url, params: {
      user: {
        username: "NewUsername",
        bio: "This is my new bio.",
        current_password: "" # Intentionally blank
      }
    }
    assert_redirected_to root_url
    @user.reload
    assert_equal "NewUsername", @user.username
    assert_equal "This is my new bio.", @user.bio
  end

  test "should NOT update password without current password" do
    patch user_registration_url, params: {
      user: {
        password: "newpassword",
        password_confirmation: "newpassword",
        current_password: "" # Intentionally blank
      }
    }
    # Asserts that the page re-renders with an error, not a redirect
    assert_response :unprocessable_content
  end

  test "should update password WITH current password" do
    patch user_registration_url, params: {
      user: {
        password: "newpassword",
        password_confirmation: "newpassword",
        current_password: "password123" # The correct password from fixtures
      }
    }
    assert_redirected_to root_url
  end
end
