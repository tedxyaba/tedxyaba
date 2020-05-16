json.extract! event, :id, :title, :venue, :slug, :datetime, :description, :category, :created_at, :updated_at
if event.theme_banner.attached?
  json.theme_banner Rails.application.routes.url_helpers.url_for(event.theme_banner)
else
  json.theme_banner nil
end
json.url event_url(event, format: :json)
