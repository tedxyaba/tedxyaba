class Speaker < ApplicationRecord
  has_many :talks
  has_many :events, through: :talks

  has_one_attached :avatar
end
