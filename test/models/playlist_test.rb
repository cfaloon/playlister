require 'test_helper'

class PlaylistTest < ActiveSupport::TestCase
  # #add_song is currently the heart of the application and will have
  # the most testing
  test "#add_song" do
    # test adding a song successfully
    assert_difference 'playlists(:one).songs.count' do
      playlists(:one).add_song({ song_name: 'Song In My Head',
                                 artist_name: 'The String Cheese Incident',
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
                                 artist_name: 'The String Cheese Incident',
                                 label_name: 'Loud & Proud Records',
                                 album_name: 'Song In My Head' })
    end

    assert_difference 'Album.count', 0 do
      playlists(:one).add_song({ song_name: 'Colorado Bluebird Sky',
                                 artist_name: 'The String Cheese Incident',
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

  test "playlist must belong to a user and have a name" do
    playlist = Playlist.new(name: 'Orphan Playlist')
    assert_not playlist.save
    playlist = Playlist.new(name: 'Good Time', user: users(:two))
    assert playlist.save
  end

  test "new playlist defaults to in_progress status" do
    playlist = Playlist.new(name: 'Bazinga')
    assert playlist.in_progress?
  end

  test "user can only have one in_progress playlist" do
    playlist = Playlist.new(name: 'Bazinga', user: users(:cole))
    assert playlist.save
    assert_not Playlist.new(name: 'Other', user: users(:cole)).valid?
  end

  test "two users can each have an in_progress playlist" do
    playlist = Playlist.new(name: 'Bazinga', user: users(:cole))
    assert playlist.save
    playlist2 = Playlist.new(name: 'Necropolis', user: users(:two))
    assert playlist2.save
  end

  test "user can have two ended playlists" do
    playlist = Playlist.new(name: 'Foo', user: users(:cole), status: :ended)
    assert playlist.save
    playlist2 = Playlist.new(name: 'Bar', user: users(:two), status: :ended)
    assert playlist2.valid?
  end
end
