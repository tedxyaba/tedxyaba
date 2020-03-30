class CreateTeams < ActiveRecord::Migration[6.0]
  def change
    create_table :teams do |t|
      t.string :first_name
      t.string :last_name
      t.string :role
      t.string :linkedin_url
      t.string :twitter_handle
      t.string :bio

      t.timestamps
    end
  end
end
