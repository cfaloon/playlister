require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  test "should get show" do
    get show_user_path(username: create(:user).username)
    assert_response :success
  end
end
