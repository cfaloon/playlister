class CreateAlbumArtists < ActiveRecord::Migration[5.1]
  def change
    create_table :album_artists do |t|
      t.references :artist, foreign_key: true
      t.references :album, foreign_key: true

      t.timestamps
    end

    Artist.all.each do |artist|
      artist.albums.each do |album|
        AlbumArtist.create(album: album, artist: artist)
      end
    end
  end
end
