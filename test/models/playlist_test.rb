require 'test_helper'

class PlaylistTest < ActiveSupport::TestCase
  # #add_song is currently the heart of the application and will have
  # the most testing
  test "#add_song" do
    # test adding a song successfully
    assert_difference 'playlists(:one).songs.count' do
      playlists(:one).add_song({ song_name: 'Song In My Head',
                                 arist_name: 'The String Cheese Incident',
                                 label_name: 'Loud & Proud Records',
                                 album_name: 'Song In My Head' })
    end

    assert_difference 'Song.count' do
      playlists(:one).add_song({ song_name: 'Song In My Head',
                                 artist_name: 'Big Bad Wolf',
                                 label_name: 'Mother Goose',
                                 album_name: 'Howl at the Moon' })
    end

    assert_difference 'Song.count', 0 do
      playlists(:two).add_song({ song_name: 'Song In My Head',
                                 arist_name: 'The String Cheese Incident',
                                 label_name: 'Loud & Proud Records',
                                 album_name: 'Song In My Head' })
    end

    assert_difference 'Album.count', 0 do
      playlists(:one).add_song({ song_name: 'Colorado Bluebird Sky',
                                 arist_name: 'The String Cheese Incident',
                                 label_name: 'Loud & Proud Records',
                                 album_name: 'Song In My Head' })
    end

    assert_difference 'Label.count', 0 do
      playlists(:one).add_song({ song_name: 'Magnetic',
                                 artist_name: 'Flyleaf',
                                 label_name: 'Loud & Proud Records',
                                 album_name: 'Between The Stars' })                          
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
