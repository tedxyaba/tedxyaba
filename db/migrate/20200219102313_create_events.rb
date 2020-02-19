class CreateEvents < ActiveRecord::Migration[6.0]
  def change
    create_table :events do |t|
      t.string :title
      t.string :venue
      t.date :date
      t.time :time
      t.text :description

      t.timestamps
    end
  end
end
