require 'test_helper'

class PlaylistSongsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @playlist = create(:playlist)
    sign_in @playlist.user
    @playlist.add_song(artist_name: 'Shane MacGowan and the Popes',
                      song_name: 'Victoria',
                      album_name: 'The Snake',
                      label_name: 'ZTT Records')
    @playlist.add_song(artist_name: 'Scenic Void',
                      song_name: 'Blue Lamp',
                      album_name: 'Scenic Void EP',
                      label_name: 'Dancing Berries Music')
  end

  test 'move_lower' do
    patch move_lower_playlist_song_path(@playlist.playlist_songs.first)
    assert_response :redirect
  end

  test 'move_higher' do
    patch move_higher_playlist_song_path(@playlist.playlist_songs.last)
    assert_response :redirect
  end

  test 'destroy' do
    delete playlist_song_path(@playlist.playlist_songs.first)
    assert_response :redirect
  end
end
