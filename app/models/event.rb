class Event < ApplicationRecord
  has_many :talks
  has_many :speakers, through: :talks

  has_many :event_partners
  has_many :partners, through: :event_partners
end
