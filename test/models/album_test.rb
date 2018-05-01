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
end
