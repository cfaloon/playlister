class AddPositionToPlaylistSongs < ActiveRecord::Migration[5.1]
  def change
    add_column :playlist_songs, :position, :integer
    Playlist.all.each do |playlist|
      playlist.playlist_songs.order(:created_at).each.with_index(1) do |ps, i|
        ps.update(position: i)
      end
    end
  end
end
