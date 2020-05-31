if @event
  json.extract! @event, :id, :title, :venue, :slug, :datetime, :description, :category, :registration_link, :created_at, :updated_at
  json.url event_url(@event, format: :json)
  if @event.theme_banner.attached?
    json.theme_banner Rails.application.routes.url_helpers.url_for(@event.theme_banner)
  else
    json.theme_banner nil
  end
  json.talks @event.talks.where.not(video_url: [nil, '']), partial: "events/talk", as: :talk
  json.partners @event.partners, partial: "partners/partner", as: :partner
  json.speakers @event.talks, partial: "events/speaker", as: :talk
end
