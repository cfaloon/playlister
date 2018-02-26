class LabelsController < ApplicationController
  def index
    @labels = Label.order(:name).page params[:page]
  end

  def show
    @label = Label.where(id: params[:id]).includes(:artists, :albums).first
  end
end
