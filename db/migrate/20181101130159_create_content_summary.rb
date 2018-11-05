class CreateContentSummary < ActiveRecord::Migration[5.2]
  def change
    create_table :content_summaries do |t|
      t.references :user, foreign_key: true
      t.references :content, foreign_key: true
      t.column :type_content_summary, :content_summary_type
      t.string :description
      t.string :text
      t.datetime :inactivated_at
    end
  end
end
