# frozen_string_literal: true

require "test_helper"

class Users::RegistrationsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    # ARRANGE: Create a user with our factory
    @user = create(:user)

    # ARRANGE: Sign in the user by simulating a login request
    post user_session_url, params: { user: { email: @user.email, password: @user.password } }
  end

  test "should get the edit profile page" do
    # ACT
    get edit_user_registration_url

    # ASSERT
    assert_response :success
  end

  test "should update username and bio without requiring the current password" do
    # ACT: Send an update request for non-sensitive data with a blank current_password
    patch user_registration_url, params: {
      user: {
        username: "NewUsername",
        bio: "This is my new bio.",
        current_password: ""
      }
    }

    # ASSERT: Check for a successful redirect and that the data was updated
    assert_redirected_to root_url
    @user.reload
    assert_equal "NewUsername", @user.username
    assert_equal "This is my new bio.", @user.bio
  end

  test "should NOT update password without the correct current password" do
    # ACT: Send an update request for the password with a blank current_password
    patch user_registration_url, params: {
      user: {
        password: "newpassword",
        password_confirmation: "newpassword",
        current_password: ""
      }
    }

    # ASSERT: Check that the page re-renders with an error
    assert_response :unprocessable_content
  end

  test "should update password when the correct current password is provided" do
    # ACT: Send an update request for the password with the correct current_password
    patch user_registration_url, params: {
      user: {
        password: "newpassword",
        password_confirmation: "newpassword",
        current_password: @user.password # Use the password from the factory
      }
    }

    # ASSERT: Check for a successful redirect
    assert_redirected_to root_url
  end
end
