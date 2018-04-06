class Album < ApplicationRecord
  # relations
  has_many :songs
  has_many :album_artists
  has_many :artists, through: :album_artists
  belongs_to :label, optional: true
  # validations
  validates :name, presence: true
  validates :artists, presence: true
end
