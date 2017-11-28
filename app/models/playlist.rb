class Playlist < ApplicationRecord
  # relations
  belongs_to :user
  has_many :playlist_songs
  has_many :songs, through: :playlist_songs
  
  
  # validations
  validates :name, presence: true
  validates :user, presence: true

  # instance methods
  def add_song(add_song_params)
    label = Label.find_or_create_by(name: add_song_params[:label_name])
    artist = Artist.find_or_create_by(name: add_song_params[:artist_name])
    album = Album.find_or_create_by(name: add_song_params[:album_name],
                                    artist: artist, label: label)
    song = Song.find_or_create_by(name: add_song_params[:song_name], album: album)
    self.playlist_songs.create(song: song)
  end
end
