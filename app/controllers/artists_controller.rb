class ArtistsController < ApplicationController
  def index
    @artists = Artist.order(:name).page params[:page]
  end

  def show
    @artist = Artist.find(params[:id])
    @albums = @artist.albums.includes(:label)
  end
end
