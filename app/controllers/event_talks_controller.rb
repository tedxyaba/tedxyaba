class EventTalksController < ApplicationController
  def index
    @talks = Talk.where(event_id: params[:event_id])
  end
end
