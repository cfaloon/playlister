require 'test_helper'

class AlbumTest < ActiveSupport::TestCase
  test "creation" do
    unnamed_album = Album.new(name: nil, artists: [artists(:cream)])
    assert_not unnamed_album.save

    no_artist_album = Album.new(name: 'Gilead', artists: [])
    assert_not no_artist_album.save

    saveable_album = Album.new(name: 'Wheels of Fire', artists: [artists(:cream)])

    assert saveable_album.save
  end
end
