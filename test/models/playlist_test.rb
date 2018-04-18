require 'test_helper'

class PlaylistTest < ActiveSupport::TestCase
  # #add_song is currently the heart of the application and will have
  # the most testing
  test "#add_song" do
    # test adding a song successfully
    playlist = create(:playlist)
    assert_difference 'playlist.songs.count' do
      playlist.add_song({ song_name: 'Song In My Head',
                          artist_name: 'The String Cheese Incident',
                          label_name: 'Loud & Proud Records',
                          album_name: 'Song In My Head' })
    end
    # Song with same name, but by different artist is a unique record.
    assert_difference 'Song.count' do
      playlist.add_song({ song_name: 'Song In My Head',
                          artist_name: 'Big Bad Wolf',
                          label_name: 'Mother Goose',
                          album_name: 'Howl at the Moon' })
    end
    # Add a second occurance of a song already played, no no song record should be created.
    playlist_two = create(:playlist, user: build(:user2))
    assert_difference 'Song.count', 0 do
      playlist_two.add_song({ song_name: 'Song In My Head',
                              artist_name: 'The String Cheese Incident',
                              label_name: 'Loud & Proud Records',
                              album_name: 'Song In My Head' })
    end
    # Second song on an existing album does not create a new Album record.
    assert_difference 'Album.count', 0 do
      playlist.add_song({ song_name: 'Colorado Bluebird Sky',
                          artist_name: 'The String Cheese Incident',
                          label_name: 'Loud & Proud Records',
                          album_name: 'Song In My Head' })
    end
    # A Label with the same name does not result in a new Label record.
    assert_difference 'Label.count', 0 do
      playlist.add_song({ song_name: 'Magnetic',
                          artist_name: 'Flyleaf',
                          label_name: 'Loud & Proud Records',
                          album_name: 'Between The Stars' })
    end
    # A new song for an exisiting Artist does not result in a new Artist record.
    assert_difference 'Artist.count', 0 do
      playlist.add_song({ song_name: 'Rosie',
                          artist_name: 'The String Cheese Incident',
                          label_name: 'Loud & Proud Records',
                          album_name: 'Song In My Head' })
    end
    # Add a song for an existing Artist, but a different Album does not result in a new Artist recrord.
    assert_difference 'Artist.count', 0 do
      playlist.add_song({ song_name: 'Drifting',
                          artist_name: 'The String Cheese Incident',
                          label_name: 'SCI Fidelity Records',
                          album_name: 'Outside Inside' })
    end
  end

  test "Compilation album creates two artists and one Album." do
    playlist = create(:playlist)
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
    playlist = build(:playlist, name: nil)
    assert_not playlist.valid?
  end

  test "cannot create playlist without played_at" do
    pl = build(:playlist, played_at: nil)
    assert_not pl.valid?
    assert pl.errors.has_key? :played_at
  end

  test "playlist must belong to a user and have a name" do
    playlist = build(:playlist, user: nil)
    assert_not playlist.valid?
    playlist = build(:playlist, name: nil)
    assert_not playlist.valid?
  end

  test "new playlist defaults to in_progress status" do
    playlist = build(:playlist)
    assert playlist.in_progress?
  end

  test "user can only have one in_progress playlist" do
    playlist = build(:playlist)
    assert playlist.save
    assert_not playlist.user.playlists.new(name: 'Some good songs', played_at: 3.days.ago).valid?
  end

  test "two users can each have an in_progress playlist" do
    playlist = build(:playlist)
    assert playlist.save
    playlist2 = build(:playlist, user: build(:user2))
    assert playlist2.save
  end

  test "user can have two ended playlists" do
    user = build(:user)
    playlist = build(:playlist, status: :ended, user: user)
    assert playlist.save
    playlist2 = build(:playlist, status: :ended, user: user)
    assert playlist2.valid?
  end
end
