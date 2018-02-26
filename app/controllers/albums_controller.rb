class AlbumsController < ApplicationController
  def index
    @albums = Album.order(:name).page params[:page]
  end

  def show
    @album = Album.find(params[:id])
  end
end
