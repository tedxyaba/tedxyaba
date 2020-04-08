json.extract! team, :id, :first_name, :last_name, :role, :linkedin_url, :twitter_handle, :bio, :created_at, :updated_at
json.url team_url(team, format: :json)
