class RenameTypeOnPerson < ActiveRecord::Migration[5.1]
  def change
    rename_column :people, :type, :type_person
  end
end
