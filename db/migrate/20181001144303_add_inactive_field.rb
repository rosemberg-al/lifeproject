class AddInactiveField < ActiveRecord::Migration[5.1]
  def change
      add_column :subjects, :inactivated_at, :datetime
  end
end
