require 'test_helper'

class PlaylistsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  test "should get new" do
    sign_in users(:cole)
    get new_playlist_url
    assert_response :success
  end

  test 'should get edit if playlist belongs to user' do
    sign_in users(:cole)
    get edit_playlist_path(playlists(:one))
    assert_response :success
  end

  test "get edit should be unauthoized if not owner" do
    sign_in users(:two)
    get edit_playlist_path(playlists(:one))
    assert_response :unauthorized
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

  test "should update existing playlist" do
    sign_in users(:cole)
    patch playlist_path(playlists(:one), playlist: { name: 'Updated!' })
    assert_response :redirect
  end

  test "should not update playlist that is not yours" do
    sign_in users(:two)
    patch playlist_path(playlists(:one), playlist: { name: 'Updated!' })
    assert_response :unauthorized
  end

  test "should get index" do
    get playlists_url
    assert_response :success
  end
end

