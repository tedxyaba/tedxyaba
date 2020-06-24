class Event < ApplicationRecord
  has_many :talks, dependent: :destroy
  has_many :speakers, through: :talks

  has_many :event_partners, dependent: :destroy
  has_many :partners, through: :event_partners

  has_one_attached :theme_banner

  CATEGORIES = ['Main Event', 'TEDxYabaWomen', 'TEDxYabaTeen', 'TEDxYabaYouth', 'TEDxYabaSalon'].freeze

  validates_inclusion_of :category, in: CATEGORIES
  validates_presence_of :slug, :title
  validates_uniqueness_of :slug

  before_save :downcase_slug

  scope :published, -> { where(is_draft: false) }

  def downcase_slug
    self.slug = self.slug.downcase
  end

  def past?
    Time.now > self.datetime
  end

  def future?
    !past?
  end

  def self.find_via_identifier(id)
    if id.to_i > 0
      where(id: id).first
    else
      where(slug: id).first
    end
  end

  def self.filtered_by_params(filters:, include_drafts:)
    filters ||= {}
    per_page_limit = (filters[:per_page] || 15).to_i
    page_count = (filters[:page_count] || 0).to_i
    offset = per_page_limit * page_count
    # default to only published events
    objs = include_drafts == 'true' ? all : published
    objs = objs.order(id: :desc)
    objs = _filter_objs_by_year(objs, filters[:event_year])
    objs = _filter_objs_by_category(objs, filters[:category])
    objs = _filter_objs_by_title(objs, filters[:event_title])
    return objs
    # return objs.offset(offset).limit(per_page_limit)
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
