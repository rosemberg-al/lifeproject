class CreateSummaryContent < ActiveRecord::Migration[5.2]
  def change
    create_table :summary_contents do |t|
      t.references :user, foreign_key: true
      t.references :content, foreign_key: true
      t.references :summary, foreign_key: true
      t.datetime :inactivated_at
      t.timestamps
    end
  end
end
