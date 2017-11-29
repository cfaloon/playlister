require 'test_helper'

class ArtistTest < ActiveSupport::TestCase
  test 'creation' do
    nameless_artist = Artist.new
    assert_not nameless_artist.save
    
    named_artist = Artist.new({ name: 'STS9' })
    assert named_artist.save
  end
end
