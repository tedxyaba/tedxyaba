class EventTalksController < ApplicationController
  def index
    @talks = Talk.where(event_id: params[:event_id])
  end

  def new
    @talk = Talk.new(event_id: params[:event_id])
    @talk.build_speaker
  end

  def create
    @talk = Talk.new(talk_params)

    if @talk.save
      redirect_to event_path(params[:event_id])
    else
      render :new
    end
  end

  private
  def talk_params
    params[:talk][:event_id] = params[:event_id]
    params.require(:talk).permit(
      :topic,
      :video_url,
      :date,
      :event_id,
      speaker_attributes: [
        :name, :email, :bio, :linkedin_url, :twitter_handle
      ]
    )
  end
end
