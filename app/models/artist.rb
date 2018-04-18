class Artist < ApplicationRecord
  # relations
  has_many :album_artists
  has_many :albums, through: :album_artists
  has_many :labels, through: :albums
  # validations
  validates :name, presence: true, uniqueness: true
end
