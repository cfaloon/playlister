class Album < ApplicationRecord
  include PgSearch
  # relations
  has_many :songs
  has_many :album_artists
  has_many :artists, through: :album_artists
  belongs_to :label, optional: true
  # validations
  validates :name, presence: true
  validates :artists, presence: true
  # scopes
  pg_search_scope :search_by_name, against: :name, using: { tsearch:
                                                            { prefix: true } }
end
