class AlbumsController < ApplicationController
  def show
    @album = Album.find(params[:id])
  end

  def index
    @albums = Album.order(:name).page params[:page]
  end
end
