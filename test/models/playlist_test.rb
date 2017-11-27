require 'test_helper'

class PlaylistTest < ActiveSupport::TestCase
  # #add_song is currently the heart of the application and will have
  # the most testing
  test "#add_song" do
    
  end

  test "cannot create unnamed playlist" do
    unnamed_playlist = Playlist.new
    assert_not unnamed_playlist.save
  end

  test "can create named playlist" do
    named_playlist = Playlist.new(name: 'Da Best Playlist')
    assert named_playlist.save
  end
end
