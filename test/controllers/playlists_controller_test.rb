require 'test_helper'

class PlaylistsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get new_playlist_url
    assert_response :success
  end

  test "should get index" do
    get playlists_url
    assert_response :success
  end

end
