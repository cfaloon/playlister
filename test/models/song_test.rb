require 'test_helper'

class SongTest < ActiveSupport::TestCase
  test "creation" do
    # requires a name to save
    nameless_song = Song.new({ name: nil,
                              playlists: [playlists(:one)],
                              album: albums(:one),
                              artist: artists(:gap) } )
    assert_not nameless_song.save

    # lack of playlist should fail to save
    no_playlist_song = Song.new({ name: 'You Dropped A Bomb On Me',
                                  playlists: [],
                                  album: albums(:one),
                                  artist: artists(:gap) } )
    assert_not no_playlist_song.save

    # lack of album should fail to save
    no_album_song = Song.new({ name: 'You Dropped A Bomb On Me',
                               playlists: [playlists(:one)],
                               album: nil,
                               artist: artists(:gap) })
    assert_not no_album_song.save

    #lack of artist shuld fail to save
    song = Song.new({ name: 'You Dropped A Bomb on Me',
                      playlists: [playlists(:one)],
                      album: albums(:five) })

    # successful save
    song = Song.new({ name: 'You Dropped A Bomb on Me',
                      playlists: [playlists(:one)],
                      album: albums(:five),
                      artist: artists(:gap) })
    assert song.save
  end
end
