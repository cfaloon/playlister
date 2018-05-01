class ArtistsController < ApplicationController
  def index
    @artists = Artist.order(:name).page params[:page]
    respond_to :html, :json
  end

  def show
    @artist = Artist.find(params[:id])
    @albums = @artist.albums.includes(:label)
  end
end
