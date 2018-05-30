# PORO for adding tracks to a Playlist record given during instantiation
class AddTrackService
  def initialize(playlist)
    @playlist = playlist
  end

  def append(song_name:, artist_name:, album_name:, label_name: nil)
    return if song_name.blank? || artist_name.blank? || album_name.blank?
    label = label_name ? Label.find_or_create_by(name: label_name.strip) : nil
    artist = Artist.find_or_create_by(name: artist_name.strip)
    album = Album.find_or_create_by(name: album_name)
    song = Song.find_or_create_by(artist: artist, name: song_name.strip, album: album)
    album.update(artists: album.artists << artist) unless album.artists.include? artist
    song.update(playlists: song.playlists << @playlist)
  end
end
