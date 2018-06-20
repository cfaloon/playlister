class Playlist < ApplicationRecord
  # relations
  belongs_to :user
  has_many :playlist_songs, -> { order(position: :asc) }
  has_many :songs, through: :playlist_songs

  # validations
  validates :name, presence: true
  validates :user, presence: true
  validates :played_at, presence: true
  validates :status, uniqueness: { scope: :user, if: :in_progress? }

  # status enum
  enum status: [:in_progress, :ended]
end
