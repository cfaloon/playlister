class PlaylistsController < ApplicationController
  before_action :find_playlist, only: [:show, :add_song]
  before_action :authenticate_user!, only: [:new, :create]

  def index
    @playlists = Playlist.all
  end

  def show
    @songs = @playlist.songs.includes(album: [:artist, :label])
  end

  def new
    @playlist = Playlist.new
  end

  def create
    @playlist = Playlist.new(playlist_params.merge(user: current_user))

    if @playlist.save
      render 'playlists/show'
    else
      render 'playlists/new'
    end
  end

  def add_song
    @playlist.add_song(add_song_params)
    redirect_to playlist_path(@playlist)
  end

  private
  def add_song_params
    params.permit([:artist_name, :album_name, :label_name, :song_name])
  end

  def playlist_params
    params.require(:playlist).permit([:name])
  end

  def find_playlist
    @playlist = Playlist.find(params[:id])
  end
end
