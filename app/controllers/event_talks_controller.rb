class EventTalksController < ApplicationController
  def index
    @talks = Talk.where(event_id: params[:event_id])
  end

  def new
    @talk = Talk.new(event_id: params[:event_id])
    @talk.build_speaker
  end

  def edit
    @talk = Talk.find(params[:id])
  end

  def update
    @talk = Talk.find(params[:id])

    if @talk.update(talk_params)
      redirect_to event_path(params[:event_id])
    else
      render :edit
    end
  end

  def create
    @talk = Talk.new(talk_params)

    if @talk.save
      redirect_to event_path(params[:event_id])
    else
      render :new
    end
  end

  def destroy
    talk = Talk.find(params[:id])
    event = talk.event
    talk.destroy
    respond_to do |format|
      format.html { redirect_to event, notice: 'Deleted.' }
      format.json { head :no_content }
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
        :id, :name, :email, :bio, :linkedin_url, :twitter_handle, :avatar
      ]
    )
  end
end
