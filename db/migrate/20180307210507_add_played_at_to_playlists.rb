class AddPlayedAtToPlaylists < ActiveRecord::Migration[5.1]
  def change
    add_column :playlists, :played_at, :datetime
  end
end
