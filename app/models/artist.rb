class Artist < ApplicationRecord
  has_many :albums
  has_many :labels, through: :albums
end
