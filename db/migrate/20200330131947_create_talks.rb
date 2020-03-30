class CreateTalks < ActiveRecord::Migration[6.0]
  def change
    create_table :talks do |t|
      t.references :speaker, null: false, foreign_key: true
      t.string :topic
      t.string :video_url
      t.date :date
      t.references :event, null: false, foreign_key: true

      t.timestamps
    end
  end
end
