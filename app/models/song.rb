class Song < ApplicationRecord
  # relations
  belongs_to :album
  belongs_to :artist
  has_many :playlist_songs
  has_many :playlists, through: :playlist_songs
  # validations
  validates :name, :playlists, presence: true
end
