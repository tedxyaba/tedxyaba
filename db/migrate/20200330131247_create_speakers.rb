class CreateSpeakers < ActiveRecord::Migration[6.0]
  def change
    create_table :speakers do |t|
      t.string :name
      t.string :email
      t.string :bio
      t.string :linkedin_url
      t.string :twitter_handle

      t.timestamps
    end
  end
end
