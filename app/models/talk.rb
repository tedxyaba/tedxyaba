class Talk < ApplicationRecord
  belongs_to :speaker
  belongs_to :event

  accepts_nested_attributes_for :speaker

  scope :published, -> { joins(:event).where(events: {is_draft: false}) }
end
