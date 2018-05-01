class LabelsController < ApplicationController
  def index
    if params.key? :q
      @labels = Label.search_by_name(params[:q])
    else
      @labels = Label.all
    end
    @labels = @labels.order(:name).page params[:page]
    respond_to :html, :json
  end

  def show
    @label = Label.find(params[:id])
  end
end
