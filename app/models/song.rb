class Song < ApplicationRecord
  # relations
  belongs_to :album
  has_many :playlist_songs, inverse_of: :song
  has_many :playlists, through: :playlist_songs
  # validations
  validates :name, :playlists, presence: true
end
