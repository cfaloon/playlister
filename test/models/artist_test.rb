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
end
