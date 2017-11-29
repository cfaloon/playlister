class Album < ApplicationRecord
  # relations
  has_many :songs
  belongs_to :artist
  belongs_to :label, optional: true
  # validations
  validates :name, presence: true
end
