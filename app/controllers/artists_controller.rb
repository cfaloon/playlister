class ArtistsController < ApplicationController
  def index
    if params.key? :q
      @artists = Artist.search_by_name params[:q]
    else
      @artists = Artist.all
    end
    @artists = @artists.order(:name).page params[:page]
    respond_to :html, :json
  end

  def show
    @artist = Artist.find(params[:id])
    @albums = @artist.albums.includes(:label)
  end
end
