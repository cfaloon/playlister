class PlaylistSongsController < ApplicationController
  before_action :set_playlist_song

  def edit
  end

  def move_lower
    @playlist_song.move_lower
    flash[:notice] = "Song moved."

    respond_to do |format|
      format.js { render 'playlists/update_table' }
      format.html { redirect_to @playlist_song.playlist }
    end
  end

  def move_higher
    @playlist_song.move_higher
    flash[:notice] = "Song moved."

    respond_to do |format|
      format.js { render 'playlists/update_table' }
      format.html { redirect_to @playlist_song.playlist }
    end
  end

  def destroy
    if @playlist_song.destroy
      flash[:notice] = "#{@playlist_song.song.name} removed from playlist."
    else
      flash[:alert] = "Couln't remove song from playlist."
    end

    respond_to do |format|
      format.js { render 'playlists/update_table' }
      format.html { redirect_to @playlist_song.playlist }
    end
  end

  private

  def set_playlist_song
    @playlist_song = PlaylistSong.find(params[:id])
  end
end
