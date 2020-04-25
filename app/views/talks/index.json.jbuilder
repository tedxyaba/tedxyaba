json.array! @talks do |talk|
  json.topic talk.topic
  json.video_url talk.video_url
  json.event_id talk.event_id

  json.speaker do
    json.name talk.speaker.name
    json.twitter_handle talk.speaker.twitter_handle
    json.linkedin_url talk.speaker.linkedin_url
  end
end
