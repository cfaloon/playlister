require 'test_helper'

class SongTest < ActiveSupport::TestCase
  test "creation" do
    # requires a name to save
    nameless_song = build(:song, name: nil)
    assert_not nameless_song.valid?
  end

  test 'no playlist' do
    # lack of playlist should fail to save
    no_playlist_song = build(:song, playlists: [])
    assert_not no_playlist_song.valid?
  end

  test 'no album' do
    # lack of album should fail to save
    no_album_song = build(:song, album: nil)
    assert_not no_album_song.valid?
  end

  test 'no artist' do
    # lack of artist should fail to save
    no_artist_song = build(:song, artist_id: nil)
    assert_not no_artist_song.valid?
  end

  test 'success' do
    # successful save
    song = build(:song)
    assert song.valid?
  end
end
