class EventPartner < ApplicationRecord
  belongs_to :event
  belongs_to :partner
end
