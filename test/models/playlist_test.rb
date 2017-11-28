require 'test_helper'

class PlaylistTest < ActiveSupport::TestCase
  # #add_song is currently the heart of the application and will have
  # the most testing
  test "#add_song" do
    assert_difference 'playlists(:one).songs.count' do
      playlists(:one).add_song({ song_name: 'Song In My Head', arist_name: 'The String Cheese Incident',
                                 label_name: 'Loud & Proud Records', album_name: 'Song In My Head'
                               })
    end
  end

  test "cannot create unnamed playlist" do
    unnamed_playlist = Playlist.new
    assert_not unnamed_playlist.save
  end

  test "can create named playlist" do
    named_playlist = Playlist.new(name: 'Da Best Playlist', user: users(:cole))
    assert named_playlist.save
  end

  test "playlist must belong to a user" do
    playlist = Playlist.new(name: 'Orphan Playlist')
    assert_not playlist.save
    playlist = Playlist.new(name: 'Good Time', user: users(:cole))
    assert playlist.save
  end
end
