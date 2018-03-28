class PlaylistSongsControllerTest < ActionDispatch::IntegrationTest
  test 'move_lower' do
    patch move_lower_playlist_song_path(playlists(:one).playlist_songs.first)
    assert_response :redirect
  end

  test 'move_higher' do
    patch move_higher_playlist_song_path(playlists(:one).playlist_songs.first)
    assert_response :redirect
  end

  test 'destroy' do
    delete playlist_song_path(playlists(:one).playlist_songs.first)
    assert_response :redirect
  end
end
