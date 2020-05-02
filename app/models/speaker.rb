class Speaker < ApplicationRecord
  has_many :talks
  has_many :events, through: :talks

  has_one_attached :avatar

  # hate this patch: https://github.com/rails/rails/issues/37701
  def changed_for_autosave?
    if avatar.attached?
      super || avatar.changed_for_autosave?
    else
      super
    end
  end
end
