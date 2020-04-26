class Event < ApplicationRecord
  has_many :talks
  has_many :speakers, through: :talks

  has_many :event_partners
  has_many :partners, through: :event_partners

  CATEGORIES = ['Main Event', 'TEDxYabaWomen', 'TEDxYabaTeen', 'TEDxYabaYouth', 'TEDxYabaSalon'].freeze

  validates_inclusion_of :category, in: CATEGORIES

  scope :published, -> { where(is_draft: false) }

  def self.filtered_by_params(filter_params)
    filter_params ||= {}
    # default to only published events
    objs = filter_params[:draft] ? all : published
    objs = _filter_objs_by_year(objs, filter_params[:event_year]) if filter_params[:event_year].present?
    objs = _filter_objs_by_category(objs, filter_params[:category]) if filter_params[:category].present?
    objs = _filter_objs_by_title(objs, filter_params[:event_title]) if filter_params[:event_title].present?
    return objs
  end


  private
  def self._filter_objs_by_year(objs, event_year)
    objs.where('extract(year from datetime) = ?', event_year.to_s)
  end

  def self._filter_objs_by_category(objs, category)
    objs.where(category: category)
  end

  def self._filter_objs_by_title(objs, event_title)
    objs.where('lower(title) ilike ?', "%#{event_title.downcase}%")
  end
end
