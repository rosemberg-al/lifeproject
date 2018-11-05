class CreatePerson < ActiveRecord::Migration[5.1]
  def change
    create_table :people do |t|
      t.string :name
      t.references :user, foreign_key: true
      t.column :type, :person_type
      t.string :biography
      t.string :main_thoughts
      t.datetime :inactivated_at

      t.timestamps
    end

    add_index :people, :type
  end
end
