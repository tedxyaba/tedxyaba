json.extract! event, :id, :title, :venue, :date, :time, :description, :created_at, :updated_at
json.url event_url(event, format: :json)
