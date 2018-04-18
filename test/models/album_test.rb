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
end
