class EventsController < ApplicationController
  before_action :set_event, only: [:edit, :update, :destroy]

  # GET /events
  # GET /events.json
  def index
    if request.format.json?
      @events = Event.filtered_by_params(filters: params[:filters], include_drafts: params[:include_drafts])
    else
      @events = Event.all
    end
  end

  # GET /events/1
  # GET /events/1.json
  def show
    if request.format.json?
      @event = Event.includes(
        talks: :speaker,
        event_partners: :partner
      ).find_via_identifier(params[:id])
    else
      @event = Event.includes(talks: :speaker).find(params[:id])
    end
  end

  # GET /events/new
  def new
    @event = Event.new(is_draft: true)
  end

  # GET /events/1/edit
  def edit
  end

  # POST /events
  # POST /events.json
  def create
    @event = Event.new(event_params)
    @event.slug = @event.title.downcase[0..6] unless @event.slug.present?

    respond_to do |format|
      if @event.save
        format.html { redirect_to @event, notice: 'Event was successfully created.' }
        format.json { render :show, status: :created, location: @event }
      else
        format.html { render :new }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /events/1
  # PATCH/PUT /events/1.json
  def update
    respond_to do |format|
      if @event.update(event_params)
        format.html { redirect_to @event, notice: 'Event was successfully updated.' }
        format.json { render :show, status: :ok, location: @event }
      else
        format.html { render :edit }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    @event.destroy
    respond_to do |format|
      format.html { redirect_to events_url, notice: 'Event was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @event = Event.includes(talks: :speaker).find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def event_params
      params.require(:event).permit(
        :title,
        :venue,
        :datetime,
        :description,
        :category,
        :is_draft,
        :slug,
        :theme_banner,
        :registration_link
      )
    end
end
