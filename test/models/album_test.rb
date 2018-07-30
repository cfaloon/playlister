require 'test_helper'

class AlbumTest < ActiveSupport::TestCase
  test "unnamed album" do
    album = build(:album, name: nil)
    assert_not album.valid?
  end

  test 'no artist album' do
    album = build(:album, artists: [])
    assert_not album.valid?
  end

  test 'valid album' do
    album = build(:album)
    assert album.valid?
  end

  test '.search_by_name' do
    album = create(:album, name: 'Charnel Ground', artists: [create(:artist, name: 'Charnel Ground')])
    assert_includes Album.search_by_name('Charnel'), album
  end

  test '#playlists' do
    playlist = create(:playlist)
    AddTrackService.new(playlist).append(song_name: 'Playa La Ticla', album_name: 'Charnel Ground', artist_name: 'Charnel Ground', label_name: '12XU')
    album = Album.find_by(name: 'Charnel Ground')

    assert album.playlists.include?(playlist)
  end
end
