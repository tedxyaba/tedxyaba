class Talk < ApplicationRecord
  belongs_to :speaker
  belongs_to :event
end
