require 'test_helper'

class PlaylistsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  test "should get new" do
    sign_in users(:cole)
    get new_playlist_url
    assert_response :success
  end

  test "should redirect on new without authentication" do
    get new_playlist_url
    assert_response :redirect
    assert_redirected_to new_user_session_path
  end

  test "should create new playlist" do
    sign_in users(:cole)
    post playlists_path(playlist: { name: 'Da Best' })
    assert_response :success
  end

  test "should get index" do
    get playlists_url
    assert_response :success
  end
end
