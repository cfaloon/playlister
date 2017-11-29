class Artist < ApplicationRecord
  # relations
  has_many :albums
  has_many :labels, through: :albums
  # validations
  validates :name, presence: true
end
