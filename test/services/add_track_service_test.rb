require 'test_helper'

class AddTrackServiceTest < ActiveSupport::TestCase
  setup do
    @playlist = create(:playlist)
    @subject = AddTrackService.new(@playlist)
  end

  test 'it adds a track with song, artist, album and label names' do
    assert_difference '@playlist.songs.count' do
      @subject.append(song_name: 'foo',
                      artist_name: 'bar',
                      album_name: 'arr',
                      label_name: 'parr')
    end
  end

  test 'it adds a track with a song, artist and album (no label)' do
    assert_difference '@playlist.songs.count' do
      @subject.append(song_name: 'foo',
                      artist_name: 'bar',
                      album_name: 'arr',
                      label_name: nil)
    end
  end

  test 'it adds a track to playlist without duplicating existing artist'
  test 'it adds a track to playlist without duplicating existing album'
  test 'it adds a track to playlist without duplicating existing label'
  test 'it adds a track to playlist without duplicating existing song'

  test 'it adds NOTHING without successful Artist creation or retrieval'
  test 'it adds NOTHING without successful Album creation or retrieval'
  test 'it adds NOTHING without successful Song creation or retrieval'

  test 'it adds multiple artists to an album (compilation)'
end
