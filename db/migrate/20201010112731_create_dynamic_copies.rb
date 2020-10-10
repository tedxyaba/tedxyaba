class CreateDynamicCopies < ActiveRecord::Migration[6.0]
  def change
    create_table :dynamic_copies do |t|
      t.string :key
      t.text :copy
    end
  end
end
