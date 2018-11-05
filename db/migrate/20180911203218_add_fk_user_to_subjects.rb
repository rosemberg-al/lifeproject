class AddFkUserToSubjects < ActiveRecord::Migration[5.1]
  def change
    add_foreign_key :subjects, :users
  end
end
