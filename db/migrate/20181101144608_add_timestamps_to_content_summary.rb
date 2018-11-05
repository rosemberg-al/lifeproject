class AddTimestampsToContentSummary < ActiveRecord::Migration[5.2]
  def change      
      change_table(:content_summaries) { |t| t.timestamps }
  end
end
