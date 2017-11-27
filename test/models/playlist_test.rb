require 'test_helper'

class PlaylistTest < ActiveSupport::TestCase
  # #add_song is currently the heart of the application and will have
  # the most testing
  test "#add_song" do
    playlists(:one).add_song({ song_name: 'Song In My Head', arist_name: 'The String Cheese Incident',
                   label_name: 'Loud & Proud Records', album_name: 'Song In My Head'
                 })
    assert_equal 1, Song.count
    assert_equal 1, Artist.count
    assert_equal 1, Album.count
    assert_equal 1, Label.count
  end

  test "cannot create unnamed playlist" do
    unnamed_playlist = Playlist.new
    assert_not unnamed_playlist.save
  end

  test "can create named playlist" do
    named_playlist = Playlist.new(name: 'Da Best Playlist')
    assert named_playlist.save
  end
end
