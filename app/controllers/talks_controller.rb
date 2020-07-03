class TalksController < ApplicationController
  def index
    @talks = Talk.filtered_by_params(filters: params[:filters], include_drafts: params[:include_drafts])
    @total_count = Talk.filtered_by_params_total_count(filters: params[:filters], include_drafts: params[:include_drafts])
  end
end
