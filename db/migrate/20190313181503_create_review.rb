class CreateReview < ActiveRecord::Migration[5.2]
  def change
    create_table :reviews do |t|
      t.string :description
      t.string :review
      t.integer :rating
      t.datetime :inactivated_at
      t.references :user, foreign_key: true
      t.references :content, foreign_key: true
      t.column :type_review, :review_type
      t.timestamps
    end
    #add_index :reviews, :user_id
    #add_index :reviews, :content_id
  end
end
