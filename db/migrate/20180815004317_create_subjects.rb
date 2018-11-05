class CreateSubjects < ActiveRecord::Migration[5.1]
  def change
    create_table :subjects do |t|
      t.string :description
      t.integer :id_user
      t.timestamps
    end
  end
end
