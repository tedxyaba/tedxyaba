class ChangeDataTypeForSpeakerBio < ActiveRecord::Migration[6.0]
  def change
    change_column(:speakers, :bio, :text)
  end
end
