class AddArtistRefToSongs < ActiveRecord::Migration[5.1]
  def up
    add_reference :songs, :artist, foreign_key: true
    Song.all.each do |song|
      artist_id = song.album.artist_id
      unless artist_id
        puts "SKIPPED #{song.name}"
        next
      end
      song.update(artist_id: artist_id)
    end
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
