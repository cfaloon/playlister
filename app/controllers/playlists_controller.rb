class PlaylistsController < ApplicationController
  before_action :find_playlist, only: [:show, :edit, :update, :add_track, :end]
  before_action :authenticate_user!, only: [:new, :edit, :update, :create]

  def index
    @playlists = Playlist.order(created_at: :desc).includes(:user).page params[:page]
  end

  def show
  end

  def new
    if current_user.playlists.in_progress.any?
      flash[:notice] = "You cannot start a new playlist until you end your current playlist."
      redirect_to current_user.playlists.in_progress.first
    end
    @playlist = Playlist.new
  end

  def edit
    unless @playlist.user_id == current_user.id
      render text: 'UNAUTHORIZED', status: :unauthorized
    end
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

  def update
    if @playlist.user_id != current_user.id
      redirect_to @playlist, notice: 'Unauthorized action'
    elsif @playlist.update(playlist_params)
      redirect_to @playlist, notice: 'Playlist was successfully updated.'
    else
      render 'playlists/edit'
    end
  end

  def add_track
    AddTrackService.new(@playlist).append(add_track_params)
    redirect_to playlist_path(@playlist)
  end

  def end
    authorize! :update, @playlist
    @playlist.ended!
    redirect_to playlists_path
  end

  private
  def add_track_params
    {
      artist_name: params[:artist_name],
      album_name: params[:album_name],
      song_name: params[:song_name],
      label_name: params[:label_name]
    }
  end

  def playlist_params
    params.require(:playlist).permit [:name, :played_at]
  end

  def find_playlist
    @playlist = Playlist.find(params[:id])
  end
end
