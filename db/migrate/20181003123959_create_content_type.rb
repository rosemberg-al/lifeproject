class CreateContentType < ActiveRecord::Migration[5.1]
  def change
    create_table :content_types do |t|
      t.string :description
      t.datetime :inactivated_at
      t.references :user, foreign_key: true
      t.timestamps
    end
  end
end
