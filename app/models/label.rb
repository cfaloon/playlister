class Label < ApplicationRecord
  include PgSearch
  # relations
  has_many :albums
  has_many :artists, through: :albums
  # validations
  validates :name, presence: true, uniqueness: true
  # scopes
  pg_search_scope :search_by_name, against: :name, using: { tsearch:
                                                            { prefix: true } }
end
