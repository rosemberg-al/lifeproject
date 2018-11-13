class CreateQuotationPerson < ActiveRecord::Migration[5.2]
  def change
    create_table :quotation_people do |t|
      t.datetime :inactivated_at
      t.references :user, foreign_key: true
      t.references :quotation, foreign_key: true
      t.references :person, foreign_key: true
      t.column :type_person, :content_person_type

      t.timestamps
    end
  end
end
