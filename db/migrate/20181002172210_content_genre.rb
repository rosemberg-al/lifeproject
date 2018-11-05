class ContentGenre < ActiveRecord::Migration[5.1]
  def change
    create_table :content_genres do |t|
      t.string :description
      t.references :user, foreign_key: true
      t.datetime :inactivated_at
      t.timestamps
    end
    #add_foreign_key :content_genres, :users
  end
end
