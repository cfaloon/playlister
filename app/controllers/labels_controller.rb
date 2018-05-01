class LabelsController < ApplicationController
  def index
    @labels = Label.search_by_name(params[:q]) if params.key? :q
    @labels ||= Label.all
    @labels = @labels.order(:name).page params[:page]
    respond_to :html, :json
  end

  def show
    @label = Label.find(params[:id])
  end
end
