json.extract! talk, :id, :topic
json.speaker_name talk.speaker.name
json.speaker_email talk.speaker.email
json.speaker_bio talk.speaker.bio
json.speaker_linkedin_url talk.speaker.linkedin_url
json.speaker_twitter_handle talk.speaker.twitter_handle
if talk.speaker.avatar.attached?
  json.image_url Rails.application.routes.url_helpers.url_for(talk.speaker.avatar)
else
  json.image_url nil
end
