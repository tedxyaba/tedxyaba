class EventPartnersController < ApplicationController
  before_action :set_event

  def index
    @partners = @event.partners
  end

  def new
    @partner = Partner.new
  end

  def edit
    @partner = Partner.find(params[:id])
  end

  def update
    @partner = Partner.find(params[:id])

    if @partner.update(partner_params)
      redirect_to event_partners_path(params[:event_id])
    else
      render :edit
    end
  end

  def create
    partner = Partner.new(partner_params)

    if EventPartner.create(partner: partner, event: @event)
      redirect_to event_partners_path(params[:event_id])
    else
      render :new
    end
  end

  def destroy
    partner = Partner.find(params[:id])
    partner.destroy
    respond_to do |format|
      format.html { redirect_to @event, notice: 'Deleted.' }
      format.json { head :no_content }
    end
  end

  private
  def set_event
    @event = Event.find(params[:event_id])
  end

  def partner_params
    params.require(:partner).permit(:name, :logo)
  end
end
