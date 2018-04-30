class Artist < ApplicationRecord
  include PgSearch
  # relations
  has_many :album_artists
  has_many :albums, through: :album_artists
  has_many :labels, through: :albums
  # validations
  validates :name, presence: true, uniqueness: true
  # scopes
  pg_search_scope :search_by_name, against: :name, using: { tsearch:
                                                            { prefix: true } }
end
