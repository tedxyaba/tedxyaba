class Partner < ApplicationRecord
  has_many :event_partners
  has_many :events, through: :event_partners
end
