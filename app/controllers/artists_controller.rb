class ArtistsController < ApplicationController
  def index
    @artists = Artist.search_by_name(params[:q]) if params.key? :q
    @artists ||= Artist.all
    @artists = @artists.order(:name).page params[:page]
    respond_to :html, :json
  end

  def show
    @artist = Artist.find(params[:id])
    @albums = @artist.albums.includes(:label)
  end
end
