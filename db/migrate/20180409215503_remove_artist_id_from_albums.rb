class RemoveArtistIdFromAlbums < ActiveRecord::Migration[5.1]
  def change
    remove_reference :albums, :artist
  end
end
