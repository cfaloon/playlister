class UsersController < ApplicationController

  def show
    @user = User.find_by_username(params[:username])
    @playlists = @user.playlists.page params[:page]
  end
end
