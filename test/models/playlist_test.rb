require 'test_helper'

class PlaylistTest < ActiveSupport::TestCase
  test "cannot create unnamed playlist" do
    playlist = build(:playlist, name: nil)
    assert_not playlist.valid?
  end

  test "cannot create playlist without played_at" do
    pl = build(:playlist, played_at: nil)
    assert_not pl.valid?
    assert pl.errors.has_key? :played_at
  end

  test "playlist must belong to a user and have a name" do
    playlist = build(:playlist, user: nil)
    assert_not playlist.valid?
    playlist = build(:playlist, name: nil)
    assert_not playlist.valid?
  end

  test "new playlist defaults to in_progress status" do
    playlist = build(:playlist)
    assert playlist.in_progress?
  end

  test "user can only have one in_progress playlist" do
    playlist = build(:playlist)
    assert playlist.save
    assert_not playlist.user.playlists.new(name: 'Some good songs', played_at: 3.days.ago).valid?
  end

  test "two users can each have an in_progress playlist" do
    playlist = build(:playlist)
    assert playlist.save
    playlist2 = build(:playlist, user: build(:user2))
    assert playlist2.save
  end

  test "user can have two ended playlists" do
    user = build(:user)
    playlist = build(:playlist, status: :ended, user: user)
    assert playlist.save
    playlist2 = build(:playlist, status: :ended, user: user)
    assert playlist2.valid?
  end
end
