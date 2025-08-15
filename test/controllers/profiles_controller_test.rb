require "test_helper"

class ProfilesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
  end

  test "should get show" do
    get profile_url(@user) # Use the correct URL helper and pass the user
    assert_response :success
  end
end
