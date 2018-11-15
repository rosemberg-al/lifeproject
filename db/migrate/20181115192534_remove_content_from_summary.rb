class RemoveContentFromSummary < ActiveRecord::Migration[5.2]
  def change
    remove_column :summaries, :content_id, :integer
  end
end
