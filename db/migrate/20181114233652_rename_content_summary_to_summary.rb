class RenameContentSummaryToSummary < ActiveRecord::Migration[5.2]
  def change
     rename_column :content_summaries, :type_content_summary, :type_summary
     rename_table :content_summaries, :summaries
  end
end
