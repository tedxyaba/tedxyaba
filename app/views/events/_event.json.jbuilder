json.extract! event, :id, :title, :venue, :datetime, :description, :created_at, :updated_at
json.url event_url(event, format: :json)
