class AlbumsController < ApplicationController
  def index
    @albums = Album.order(:name).includes(:artist).page params[:page]
  end

  def show
    @album = Album.find(params[:id])
  end
end
