class CreateContent < ActiveRecord::Migration[5.1]
  def change
    create_table :contents do |t|
      t.string :description
      t.datetime :inactivated_at
      t.references :user, foreign_key: true
      t.references :content_type, foreign_key: true
      t.references :content_genre, foreign_key: true
      t.string :synopsis
      t.string :book_publisher
      t.datetime :book_date_published
      t.string :movie_company
      t.datetime :movie_date_released
      t.time :movie_time

      t.timestamps
    end
  end
end
