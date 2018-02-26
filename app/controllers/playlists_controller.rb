class PlaylistsController < ApplicationController
  before_action :find_playlist, only: [:show, :add_song, :end]
  before_action :authenticate_user!, only: [:new, :create]

  def index
    @playlists = Playlist.order(created_at: :desc).includes(:user).page params[:page]
  end

  def show
    @songs = @playlist.songs.order('playlist_songs.created_at').includes(album: [:artist, :label])
  end

  def new
    if current_user.playlists.in_progress.any?
      flash[:notice] = "You cannot start a new playlist until you end your current playlist."
      redirect_to current_user.playlists.in_progress.first
    end
    @playlist = Playlist.new
  end

  def create
    @playlist = Playlist.new(playlist_params.merge(user: current_user))

    if @playlist.save
      @songs = @playlist.songs
      render 'playlists/show'
    else
      render 'playlists/new'
    end
  end

  def add_song
    @playlist.add_song(add_song_params)
    redirect_to playlist_path(@playlist)
  end

  def end
    @playlist.ended!
    redirect_to playlists_path
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
