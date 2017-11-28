require 'test_helper'

class PlaylistsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  
  test "should get new" do
    sign_in users(:cole)
    get new_playlist_url
    assert_response :success
  end

  test "should get index" do
    get playlists_url
    assert_response :success
  end

end
