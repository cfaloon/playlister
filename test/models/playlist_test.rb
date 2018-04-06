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
    # Song with same name, but by different artist is a unique record.
    assert_difference 'Song.count' do
      playlists(:one).add_song({ song_name: 'Song In My Head',
                                 artist_name: 'Big Bad Wolf',
                                 label_name: 'Mother Goose',
                                 album_name: 'Howl at the Moon' })
    end
    # Add a second occurance of a song already played, no no song record should be created.
    assert_difference 'Song.count', 0 do
      playlists(:two).add_song({ song_name: 'Song In My Head',
                                 artist_name: 'The String Cheese Incident',
                                 label_name: 'Loud & Proud Records',
                                 album_name: 'Song In My Head' })
    end
    # Second song on an existing album does not create a new Album record.
    assert_difference 'Album.count', 0 do
      playlists(:one).add_song({ song_name: 'Colorado Bluebird Sky',
                                 artist_name: 'The String Cheese Incident',
                                 label_name: 'Loud & Proud Records',
                                 album_name: 'Song In My Head' })
    end
    # A Label with the same name does not result in a new Label record.
    assert_difference 'Label.count', 0 do
      playlists(:one).add_song({ song_name: 'Magnetic',
                                 artist_name: 'Flyleaf',
                                 label_name: 'Loud & Proud Records',
                                 album_name: 'Between The Stars' })
    end
    # A new song for an exisiting Artist does not result in a new Artist record.
    assert_difference 'Artist.count', 0 do
      playlists(:one).add_song({ song_name: 'Rosie',
                                 artist_name: 'The String Cheese Incident',
                                 label_name: 'Loud & Proud Records',
                                 album_name: 'Song In My Head' })
    end
    # Add a song for an existing Artist, but a different Album does not result in a new Artist recrord.
    assert_difference 'Artist.count', 0 do
      playlists(:one).add_song({ song_name: 'Drifting',
                                 artist_name: 'The String Cheese Incident',
                                 label_name: 'SCI Fidelity Records',
                                 album_name: 'Outside Inside'
        })
    end
  end

  test "Compilation album creates two artists and one Album." do
    playlist = Playlist.create(name: 'Compilation Playlist', played_at: 7.days.ago, user: users(:cole))
    playlist.add_song({ song_name: 'Be A Man',
                        artist_name: 'Dynamic Adam & His Excitements',
                        album_name: "Southern Funkin' - Louisiana Funk & Soul 1967-1979",
                        label_name: 'BGP Records' })

    assert_difference 'Album.count', 0 do
      playlist.add_song({ song_name: 'Miss Hard To Get',
                          artist_name: 'Dennis Landry',
                          album_name: "Southern Funkin' - Louisiana Funk & Soul 1967-1979",
                          label_name: 'BGP Records' })
    end


  end

  test "cannot create unnamed playlist" do
    unnamed_playlist = Playlist.new
    assert_not unnamed_playlist.save
  end

  test "cannot create playlist without played_at" do
    pl = Playlist.new(name: 'Non-chalant', played_at: nil)
    assert_not pl.valid?
    assert pl.errors.has_key? :played_at
  end

  test "playlist must belong to a user and have a name" do
    playlist = Playlist.new(name: 'Orphan Playlist', played_at: Time.now)
    assert_not playlist.save
    playlist = Playlist.new(name: 'Good Time', played_at: Time.now, user: users(:two))
    assert playlist.save
  end

  test "new playlist defaults to in_progress status" do
    playlist = Playlist.new(name: 'Bazinga', played_at: Time.now)
    assert playlist.in_progress?
  end

  test "user can only have one in_progress playlist" do
    playlist = Playlist.new(name: 'Bazinga', user: users(:cole), played_at: Time.now)
    assert playlist.save
    assert_not Playlist.new(name: 'Other', user: users(:cole), played_at: Time.now).valid?
  end

  test "two users can each have an in_progress playlist" do
    playlist = Playlist.new(name: 'Bazinga', user: users(:cole), played_at: Time.now)
    assert playlist.save
    playlist2 = Playlist.new(name: 'Necropolis', user: users(:two), played_at: Time.now)
    assert playlist2.save
  end

  test "user can have two ended playlists" do
    playlist = Playlist.new(name: 'Foo', user: users(:cole), status: :ended, played_at: Time.now)
    assert playlist.save
    playlist2 = Playlist.new(name: 'Bar', user: users(:two), status: :ended, played_at: Time.now)
    assert playlist2.valid?
  end
end
