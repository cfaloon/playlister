class LabelsController < ApplicationController
  def index
    @labels = Label.order(:name).page params[:page]
  end

  def show
    @label = Label.find(params[:id])
  end
end
