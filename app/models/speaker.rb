class Speaker < ApplicationRecord
  has_many :talks
  has_many :events, through: :talks
end
