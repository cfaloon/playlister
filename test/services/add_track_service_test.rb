require 'test_helper'

class AddTrackServiceTest < ActiveSupport::TestCase
  setup do
    @playlist = create(:playlist)
    @subject = AddTrackService.new(@playlist)
  end

  test 'it adds a track with song, artist, album and label names' do
    assert_difference '@playlist.songs.count', 1 do
      @subject.append(song_name: 'foo',
                      artist_name: 'bar',
                      album_name: 'arr',
                      label_name: 'parr')
    end
  end

  test 'it adds a track with a song, artist and album (no label)' do
    assert_difference '@playlist.songs.count', 1 do
      @subject.append(song_name: 'foo',
                      artist_name: 'bar',
                      album_name: 'arr',
                      label_name: nil)
    end
  end

  test 'it creates song, artist, album and label with all associations' do
    @subject.append(song_name: 'Ripest of Apples',
                    artist_name: 'Anna & Elizabeth',
                    album_name: 'The Invisible Comes To Us',
                    label_name: 'Smithsonian Folkways')

    assert_equal @playlist.songs.count, 1
    assert_equal @playlist.songs.first.album.name, 'The Invisible Comes To Us'
    assert_equal @playlist.songs.first.album.artists.first.name, 'Anna & Elizabeth'
    assert_equal @playlist.songs.first.album.label.name, 'Smithsonian Folkways'

  end

  # idempotent artist/album/label/song creation
  test 'it adds a track to playlist without duplicating existing artist' do
    artist = create(:artist, name: 'Miles Davis')

    assert_no_difference 'Artist.count' do
      @subject.append(song_name: 'Kind of Blue',
                      artist_name: 'Miles Davis',
                      album_name: 'Kind of Blue',
                      label_name: 'Columbia')
    end
  end
  test 'it adds a track to playlist without duplicating existing album' do
    artist = create(:artist, name: 'UB40')
    label = create(:label, name: 'DEP International')
    album = create(:album, name: 'Geffery Morgan', artists: [artist], label: label)

    assert_no_difference 'Album.count' do
      @subject.append(song_name: 'Riddle Me',
                      artist_name: 'UB40',
                      album_name: 'Geffery Morgan',
                      label_name: 'DEP International')
    end
  end
  test 'it adds a track to playlist without duplicating existing label' do
    label = create(:label, name: 'Thrill Jockey')

    assert_no_difference 'Label.count' do
      @subject.append(song_name: 'Pipevine Swallowtails',
                      artist_name: 'Sarah Louise',
                      album_name: 'Deeper Woods',
                      label_name: 'Thrill Jockey')
    end
  end
  test 'it adds a track to playlist without duplicating existing song' do
    second_user = create(:user, email: 'other_user@email.com', username: 'dos')
    old_playlist = create(:playlist, played_at: 5.months.ago, user: second_user)
    other_service = AddTrackService.new(old_playlist)
    add_track_attrs = { song_name: 'Virginia Rambler',
                       artist_name: 'Anna & Elizabeth',
                       album_name: 'The Invisible Comes To Us',
                       label_name: 'Smithsonian Folkways'
                      }

    other_service.append(add_track_attrs)

    assert_no_difference 'Song.count' do
      @subject.append(add_track_attrs)
    end
  end

  # transactional tests
  test 'it adds NOTHING without successful Artist creation or retrieval' do
    assert_no_difference 'Song.count + Album.count + Artist.count + Label.count' do
      @subject.append(song_name: 'I Just Called To Say I Love You',
                      artist_name: nil,
                      album_name: 'The Woman In Red',
                      label_name: 'Motown'
                      )
    end
  end

  test 'it adds NOTHING without successful Album creation or retrieval' do
    assert_no_difference 'Song.count + Album.count + Artist.count + Label.count' do
      @subject.append(song_name: 'I Just Called To Say I Love You',
                      artist_name: 'Stevie Wonder',
                      album_name: nil,
                      label_name: 'Motown'
                      )
    end
  end

  test 'it adds NOTHING without successful Song creation or retrieval' do
    assert_no_difference 'Song.count + Album.count + Artist.count + Label.count' do
      @subject.append(song_name: nil,
                      artist_name: 'Stevie Wonder',
                      album_name: 'The Woman In Red',
                      label_name: 'Motown'
                      )
    end
  end

  test 'it adds multiple artists to an album (compilation)' do
    album_name = "Just Can't Get Enough: New Wave Hits of the '80s vol 10"
    @subject.append(song_name: "Puttin' On The Ritz",
                    artist_name: 'Taco',
                    album_name: album_name,
                    label_name: 'Rhino')
    album = Album.find_by_name(album_name)

    assert_no_difference 'Album.count' do
      @subject.append(song_name: 'Wishing (If I Had A Photograph Of You)',
                      artist_name: 'A Flock Of Seagulls',
                      album_name: album_name,
                      label_name: 'Rhino')
    end
    assert_includes album.artists.map(&:name), 'A Flock Of Seagulls'
    assert_includes album.artists.map(&:name), 'Taco'
  end
end
