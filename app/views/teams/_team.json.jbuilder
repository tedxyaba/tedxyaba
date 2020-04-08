json.extract! team, :id, :first_name, :last_name, :role, :linkedin_url, :twitter_handle, :bio, :created_at, :updated_at
if team.avatar.attached?
  json.image_url Rails.application.routes.url_helpers.url_for(team.avatar)
else
  json.image_url nil
end
