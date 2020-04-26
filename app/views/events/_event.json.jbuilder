json.extract! event, :id, :title, :venue, :slug, :datetime, :description, :category, :created_at, :updated_at
json.url event_url(event, format: :json)
