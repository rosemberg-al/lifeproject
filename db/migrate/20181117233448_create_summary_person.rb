class CreateSummaryPerson < ActiveRecord::Migration[5.2]
  def change
    create_table :summary_people do |t|
      t.references :user, foreign_key: true
      t.references :summary, foreign_key: true
      t.references :person, foreign_key: true
      t.datetime :inactivated_at
      t.column :type_person, :content_person_type

      t.timestamps
    end
  end
end
