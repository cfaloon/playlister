require 'test_helper'

class LabelTest < ActiveSupport::TestCase
  test "creation" do
    label = build(:label, name: nil)
    assert_not label.valid?
  end

  test 'label saves duplicate name fails' do
    label = build(:label)
    assert label.save

    duplicate_label_name = build(:label)
    assert_not duplicate_label_name.valid?
  end

  test '.search_by_name' do
    label = create(:label, name: '12XU')
    assert_includes Label.search_by_name('12'), label
  end

  test '#playlists' do
    playlist = create(:playlist)
    label = create(:label, name: '12XU')
    ats = AddTrackService.new(playlist)
    ats.append(song_name: 'Vibe Killer', artist_name: 'Endless Boogie',
               album_name: 'Vibe Killer', label_name: '12XU')

    assert_includes label.playlists, playlist
  end

  test '#artists' do
    playlist = create(:playlist)
    label = create(:label, name: '12XU')
    ats = AddTrackService.new(playlist)

    ats.append(song_name: 'Vibe Killer', artist_name: 'Endless Boogie',
               album_name: 'Vibe Killer', label_name: '12XU')
    ats.append(song_name: 'Dreaming In The Non-Dream', artist_name: 'Chris Forsyth',
               album_name: 'Dreaming In The Non-Dream', label_name: '12XU')

    assert_includes label.artists, Artist.find_by(name: 'Endless Boogie')
    assert_includes label.artists, Artist.find_by(name: 'Chris Forsyth')
  end
end
