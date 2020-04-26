class Talk < ApplicationRecord
  belongs_to :speaker
  belongs_to :event

  accepts_nested_attributes_for :speaker

  scope :published, -> { joins(:event).where(events: {is_draft: false}) }

  def self.filtered_by_params(filters:, include_drafts:)
    filters ||= {}
    # default to only published talks
    objs = include_drafts == 'true' ? all : published
    objs = _filter_objs_by_year(objs, filters[:event_year])
    objs = _filter_objs_by_topic_or_speaker(objs, filters[:query])
    objs = _filter_objs_by_category(objs, filters[:category])
    objs = _filter_objs_by_events(objs, filters[:event])
    return objs
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
