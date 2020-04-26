class Event < ApplicationRecord
  has_many :talks
  has_many :speakers, through: :talks

  has_many :event_partners
  has_many :partners, through: :event_partners

  CATEGORIES = ['Main Event', 'TEDxYabaWomen', 'TEDxYabaTeen', 'TEDxYabaYouth', 'TEDxYabaSalon'].freeze

  validates_inclusion_of :category, in: CATEGORIES

  scope :published, -> { where(is_draft: false) }

  def self.filtered_by_params(filters:, include_drafts:)
    filters ||= {}
    # default to only published events
    objs = include_drafts == 'true' ? all : published
    objs = _filter_objs_by_year(objs, filters[:event_year])
    objs = _filter_objs_by_category(objs, filters[:category])
    objs = _filter_objs_by_title(objs, filters[:event_title])
    return objs
  end


  private
  def self._filter_objs_by_year(objs, event_year)
    return objs unless event_year
    objs.where('extract(year from datetime) = ?', event_year.to_s)
  end

  def self._filter_objs_by_category(objs, category)
    return objs unless category
    objs.where(category: category)
  end

  def self._filter_objs_by_title(objs, event_title)
    return objs unless event_title
    objs.where('lower(title) ilike ?', "%#{event_title.downcase}%")
  end
end
