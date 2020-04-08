class Partner < ApplicationRecord
  has_many :event_partners
  has_many :events, through: :event_partners

  has_one_attached :logo

  #todo delete logo from cloud when deleted or updated
end
