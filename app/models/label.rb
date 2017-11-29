class Label < ApplicationRecord
  # relations
  has_many :albums
  has_many :artists, through: :albums
  # validations
  validates :name, presence: true
end
