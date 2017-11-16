class LabelsController < ApplicationController
  def index
    @labels = Label.all
  end

  def show
    @label = Label.where(id: params[:id]).includes(:artists, :albums).first
  end
end
