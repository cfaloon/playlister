require 'test_helper'

class ArtistTest < ActiveSupport::TestCase
  test 'nameless artist fails' do
    artist = build(:artist, name: nil)
    assert_not artist.valid?
  end

  test 'named artist valid, duplicate name fails' do
    artist = create(:artist)
    assert artist.valid?

    duplicate_artist_name = build(:artist)
    assert_not duplicate_artist_name.valid?
  end

  test '.search_by_name' do
    artist = create(:artist, name: 'Charnel Ground')
    assert_includes Artist.search_by_name('Charnel'), artist
  end

  test '#playlists' do
    user = create(:user)
    playlist = create(:playlist, user: user)
    artist = Artist.create(name: 'Björk')
    AddTrackService.new(playlist).append(artist_name: 'Björk',
                                         song_name: 'Venus as a Boy',
                                         album_name: 'Debut',
                                         label_name: 'Elektra' )

    assert_includes artist.playlists, playlist
  end
end
