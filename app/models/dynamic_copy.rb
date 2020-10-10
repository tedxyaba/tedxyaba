class DynamicCopy < ApplicationRecord
  validates_presence_of :key, :copy

  before_save :transform_key_snake_case

  def transform_key_snake_case
    self.key = self.key.squish.tr(' ', '_').downcase
  end
end
