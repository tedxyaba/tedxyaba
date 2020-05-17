class AddRegistrationLinkToEvent < ActiveRecord::Migration[6.0]
  def change
    add_column :events, :registration_link, :string
  end
end
