json.talks @talks do |talk|
  json.id talk.id
  json.topic talk.topic
  json.video_url talk.video_url
  json.video_duration talk.video_duration
  json.date talk.date
  json.event_id talk.event_id

  json.speaker do
    json.name talk.speaker.name
    json.twitter_handle talk.speaker.twitter_handle
    json.linkedin_url talk.speaker.linkedin_url
  end
end
json.total_count @total_count
json.page_count @page_count
