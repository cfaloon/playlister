class AlbumsController < ApplicationController
  def index
    @albums = Album.search_by_name params[:q] if params.key? :q
    @albums ||= Album.all
    @albums = @albums.order(:name).includes(:artists).page params[:page]
    respond_to :html, :json
  end

  def show
    @album = Album.find(params[:id])
  end
end
