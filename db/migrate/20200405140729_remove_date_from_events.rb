class RemoveDateFromEvents < ActiveRecord::Migration[6.0]
  def change

    remove_column :events, :date, :date
    remove_column :events, :time, :time

    add_column :events, :datetime, :datetime
  end
end
