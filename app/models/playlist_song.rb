class PlaylistSong < ApplicationRecord
  # relations
  belongs_to :playlist
  belongs_to :song
  # other
  acts_as_list scope: :playlist
end
