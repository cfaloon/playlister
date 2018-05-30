require 'test_helper'

class PlaylistsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @user1 = create(:user)
    @user2 = create(:user, username: 'other_user', email: 'other_user@domain.com')
    @user1.playlists.create(attributes_for(:playlist, user: nil))
    @user2.playlists.create(attributes_for(:playlist, user: nil))
  end

  test "should get new" do
    @user1.playlists.first.ended!
    sign_in @user1
    get new_playlist_url
    assert_response :success
  end

  test 'should get edit if playlist belongs to user' do
    @user1.playlists.create(attributes_for(:playlist, user: nil))
    sign_in @user1

    get edit_playlist_path(@user1.playlists.first)
    assert_response :success
  end

  test "get edit should be unauthoized if not owner" do
    sign_in @user2
    get edit_playlist_path(@user1.playlists.first)
    assert_response :unauthorized
  end

  test "should redirect on new without authentication" do
    get new_playlist_url
    assert_response :redirect
    assert_redirected_to new_user_session_path
  end

  test "should create new playlist" do
    sign_in @user1
    post playlists_path(playlist: { name: 'Da Best' })
    assert_response :success
    end

  test "should update existing playlist" do
    sign_in @user1

    patch playlist_path(id: @user1.playlists.first.id, playlist: { name: 'Updated!' })
    assert_response :redirect
  end

  test "should not update playlist that is not yours" do
    sign_in @user2

    patch playlist_path(@user1.playlists.first, playlist: { name: 'Updated!' })
    assert_response :redirect
  end

  test "should get index" do
    get playlists_url
    assert_response :success
  end

  test "should get show" do
    get playlist_path(@user1.playlists.first)
    assert_response :success
  end

  test "should add track" do
    add_track_params = { artist_name: 'Prince',
                         album_name: "Sign 'o the Times",
                         song_name: 'Ballad of Dorothy Parker',
                         label_name: 'Paisley Park'
                       }

    assert_difference '@user1.playlists.first.songs.count', 1 do
      post add_track_playlist_path(add_track_params.merge({id: @user1.playlists.first.id}))
    end

    assert_response :redirect
  end
end
