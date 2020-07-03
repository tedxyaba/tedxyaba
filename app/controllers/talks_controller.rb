class TalksController < ApplicationController
  def index
    filters = params[:filters] || {}
    @page_count = filters[:page_count] || 1
    @talks = Talk.filtered_by_params(filters: filters, include_drafts: params[:include_drafts])
    @total_count = Talk.filtered_by_params_total_count(filters: filters, include_drafts: params[:include_drafts])
  end
end
