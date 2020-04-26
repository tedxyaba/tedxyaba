class TalksController < ApplicationController
  def index
    @talks = Talk.filtered_by_params(filters: params[:filters], include_drafts: params[:include_drafts])
  end
end
