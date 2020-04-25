class AddIsDraftToEvents < ActiveRecord::Migration[6.0]
  def change
    add_column :events, :is_draft, :boolean, default: true
  end
end
