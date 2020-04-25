class Event < ApplicationRecord
  has_many :talks
  has_many :speakers, through: :talks

  has_many :event_partners
  has_many :partners, through: :event_partners

  CATEGORIES = ['Main Event', 'TEDxYabaWomen', 'TEDxYabaTeen', 'TEDxYabaYouth', 'TEDxYabaSalon'].freeze

  validates_inclusion_of :category, in: CATEGORIES

  scope :published, -> { where(is_draft: false) }

end
