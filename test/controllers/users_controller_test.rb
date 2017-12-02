require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  test "should get show" do
    get show_user_path(users(:cole))
    assert_response :success
  end
#  test "should get new" do
#    sign_in users(:cole)
#    get new_playlist_url
#    assert_response :success
#  end
end
