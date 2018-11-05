class CreateContentPerson < ActiveRecord::Migration[5.1]
  def change
    create_table :content_people do |t|
      t.references :user, foreign_key: true
      t.references :content, foreign_key: true
      t.references :person, foreign_key: true
      t.datetime :inactivated_at
      t.column :type_content_person, :content_person_type
    end

    add_index :content_people, :type_content_person
  end
end
