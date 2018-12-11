class CreateContentSubject < ActiveRecord::Migration[5.2]
  def change
    create_table :content_subjects do |t|
      t.references :content, foreign_key: true
      t.references :user, foreign_key: true
      t.references :subject, foreign_key: true
      t.datetime :inactivated_at
      t.timestamps
    end
  end
end
