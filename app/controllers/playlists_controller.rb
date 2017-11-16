class PlaylistsController < ApplicationController
  before_action :find_playlist, only: [:show, :add_song]

  def index
    @playlists = Playlist.all
  end

  def show
  end

  def new
    @playlist = Playlist.new
  end

  def create
    @playlist = Playlist.new(playlist_params)

    if @playlist.save
      render 'playlists/show'
    else
      render 'playlists/new'
    end
  end

  def add_song

    label = Label.find_or_create_by(name: params[:label_name])
    artist = Artist.find_or_create_by(name: params[:artist_name])
    album = Album.find_or_create_by(name: params[:album_name], artist: artist, label: label)
    song = Song.find_or_create_by(name: params[:song_name], album: album)
    PlaylistSong.create(song: song, playlist: @playlist)
    redirect_to playlist_path(@playlist)
  end

  private
  def playlist_params
    params.require(:playlist).permit([:name])
  end

  def find_playlist
    @playlist = Playlist.find(params[:id])
  end
end
