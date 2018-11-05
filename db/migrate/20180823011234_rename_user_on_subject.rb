class RenameUserOnSubject < ActiveRecord::Migration[5.1]
  def change
    rename_column :subjects, :id_user, :user_id
  end
end
