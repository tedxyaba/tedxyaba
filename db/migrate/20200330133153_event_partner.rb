class CreateEventPartner < ActiveRecord::Migration[6.0]
  def change
    create_table :event_partners do |t|
      t.references :partner, null: false, foreign_key: true
      t.references :event, null: false, foreign_key: true

      t.timestamps
    end
  end
end
