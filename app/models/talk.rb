class Talk < ApplicationRecord
  YOUTUBE_CONTENT_URI = 'https://www.googleapis.com/youtube/v3/videos'.freeze

  belongs_to :speaker
  belongs_to :event

  accepts_nested_attributes_for :speaker

  before_validation :fetch_youtube_duration,
    if: -> { video_url_changed? && video_url.present? },
    unless: -> { Rails.env.test? }

  scope :published, -> { joins(:event).where(events: {is_draft: false}) }

  def fetch_youtube_duration
    params = {
      key: Rails.application.credentials.dig(:googleapis, :youtube_api_key),
      part: 'contentDetails',
      id: id_from_video_url
    }
    uri = URI(YOUTUBE_CONTENT_URI)
    uri.query = URI.encode_www_form(params)
    res = Net::HTTP.get_response(uri)
    if res.is_a?(Net::HTTPSuccess)
      j_body = JSON.parse(res.body)
      video_item = j_body['items'][0]
      if video_item
        self.video_duration = video_item['contentDetails']['duration']
      else
        errors.add(:base, 'Video URL is not a valid youtube video url')
      end
    end
  end

  def id_from_video_url
    uri = URI(video_url)
    query_params = Rack::Utils.parse_nested_query(uri.query)
    query_params['v']
  end

  def self.filtered_by_params(filters:, include_drafts:)
    filters ||= {}
    per_page_limit = (filters[:per_page] || 15).to_i
    page_count = (filters[:page_count] || 0).to_i
    offset = per_page_limit * page_count

    # default to only published talks
    objs = include_drafts == 'true' ? all : published
    objs = objs.order(id: :desc)
    objs = objs.where.not(video_url: [nil, ''])
    objs = _filter_objs_by_year(objs, filters[:event_year])
    objs = _filter_objs_by_topic_or_speaker(objs, filters[:query])
    objs = _filter_objs_by_category(objs, filters[:category])
    objs = _filter_objs_by_events(objs, filters[:event])
    return objs
    # return objs.offset(offset).limit(per_page_limit)
  end

  private
  def self._filter_objs_by_year(objs, event_year)
    return objs unless event_year
    objs.where('extract(year from date) = ?', event_year.to_s)
  end

  def self._filter_objs_by_topic_or_speaker(objs, query_term)
    return objs unless query_term
    objs.joins(:speaker).where('lower(topic) ilike ? or speakers.name ilike ?', "%#{query_term.downcase}%", "%#{query_term.downcase}%")
  end

  def self._filter_objs_by_category(objs, category)
    return objs unless category
    objs.joins(:event).where(events: {category: category})
  end

  def self._filter_objs_by_events(objs, event_ids)
    return objs unless event_ids
    objs.where(event_id: event_ids)
  end
end
