class AddBioToPartners < ActiveRecord::Migration[6.0]
  def change
    add_column :partners, :bio, :text
    add_column :partners, :link, :string
  end
end
