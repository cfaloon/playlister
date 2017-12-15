class AddStatusToPlaylists < ActiveRecord::Migration[5.1]
  def change
    add_column :playlists, :status, :integer, default: 0
  end
end
